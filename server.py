"""
CDM Generator Server
--------------------
Chay: python server.py
Mo: http://localhost:8000
"""
import os
import shutil
import subprocess
import sys
import base64
import zlib
import urllib.parse
from pathlib import Path

from fastapi import FastAPI, File, Form, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse, HTMLResponse, JSONResponse

WORK_DIR = Path(__file__).parent
OUTPUT_FILE = WORK_DIR / "cdm_output" / "cdm.drawio"
CLAUDE_FILE = WORK_DIR / "cdm_output" / "claude_cdm.drawio"
PYTHON = str(WORK_DIR / ".venv" / "Scripts" / "python.exe")

app = FastAPI(title="CDM Generator")
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])


HTML = """<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>CDM Generator</title>
<style>
  body { font-family: Segoe UI, sans-serif; max-width: 700px; margin: 40px auto; padding: 0 20px; background:#f5f5f5; }
  h1 { color: #1a6e2e; margin-bottom: 4px; }
  .card { background: #fff; border-radius: 10px; padding: 28px 32px; box-shadow: 0 2px 12px #0001; }
  label { font-weight: 600; display: block; margin-bottom: 8px; }
  input[type=file] { border: 2px dashed #ccc; border-radius: 6px; padding: 16px; width: 100%; box-sizing: border-box; cursor: pointer; }
  input[type=file]:hover { border-color: #1a6e2e; }
  button { margin-top: 14px; background: #1a6e2e; color: #fff; border: none; padding: 12px 28px;
           border-radius: 6px; font-size: 16px; cursor: pointer; width: 100%; }
  button:hover { background: #155a25; }
  #result { margin-top: 20px; display:none; }
  .link-btn { display:block; text-align:center; background:#0066cc; color:#fff; padding:11px;
              border-radius:6px; text-decoration:none; margin-top:8px; font-weight:600; font-size:14px; }
  .link-btn.dl { background:#555; }
  .info { background:#eaf4ec; border-radius:6px; padding:10px 14px; font-size:14px; color:#333; margin-bottom:4px; }
  .spinner { display:none; text-align:center; padding:16px; color:#555; font-size:14px; }
  .error { background:#fdecea; color:#c0392b; border-radius:6px; padding:12px; font-size:13px; white-space:pre-wrap; }
  #log-box { display:none; margin-top:14px; }
  #log-box summary { cursor:pointer; font-size:13px; color:#555; font-weight:600; margin-bottom:6px; }
  #log { background:#1e1e1e; color:#d4d4d4; border-radius:6px; padding:12px 14px;
         font-family:Consolas,monospace; font-size:12px; white-space:pre-wrap;
         max-height:260px; overflow-y:auto; line-height:1.5; }
  .tag-llm    { color:#4ec9b0; font-weight:bold; }
  .tag-reason { color:#ce9178; }
  .tag-ok     { color:#6a9955; }
  .tag-warn   { color:#dcdcaa; }
</style>
</head>
<body>
<div class="card">
  <h1>CDM Generator</h1>
  <p style="margin-top:4px;font-size:14px;color:#555">Upload file Excel (.xlsx) de sinh CDM draw.io.</p>
  <form id="form">
    <label>Chon file Excel:</label>
    <input type="file" id="file" name="file" accept=".xlsx" required>
    <label style="font-weight:400;font-size:14px;margin-top:12px;display:flex;align-items:center;gap:8px;cursor:pointer">
      <input type="checkbox" id="force-llm" style="width:auto;cursor:pointer">
      Force LLM (bo qua cdm_config.json &mdash; can API key)
    </label>
    <button type="submit">Tao CDM</button>
  </form>
  <div class="spinner" id="spinner">&#9881; Dang xu ly... (15-60 giay neu dung LLM)</div>
  <div id="result">
    <div class="info" id="info"></div>
    <a id="drawio-link" class="link-btn" href="#" target="_blank">&#128196; Mo trong draw.io (web)</a>
    <a class="link-btn dl" href="/download">&#8595; Tai file .drawio</a>
    <a class="link-btn dl" href="/compare" target="_blank" style="background:#2e7d32">&#128202; So sanh voi Claude CDM</a>
  </div>
  <div class="error" id="error" style="display:none"></div>
  <details id="log-box">
    <summary>Pipeline log</summary>
    <div id="log"></div>
  </details>
</div>
<script>
var NL = String.fromCharCode(10);
function colorLog(text) {
  return text.split(NL).map(function(line) {
    if (line.indexOf('[LLM CDM]') >= 0)       return '<span class="tag-llm">'    + line + '</span>';
    if (line.indexOf('[LLM reasoning]') >= 0) return '<span class="tag-reason">'  + line + '</span>';
    if (line.indexOf('[CDM]') >= 0)           return '<span class="tag-ok">'      + line + '</span>';
    if (line.indexOf('ERROR') >= 0)           return '<span class="tag-warn">'    + line + '</span>';
    return line;
  }).join(NL);
}

document.getElementById('form').onsubmit = async (e) => {
  e.preventDefault();
  const file = document.getElementById('file').files[0];
  if (!file) return;
  document.getElementById('result').style.display = 'none';
  document.getElementById('error').style.display = 'none';
  document.getElementById('log-box').style.display = 'none';
  document.getElementById('log').innerHTML = '';
  document.getElementById('spinner').style.display = 'block';

  const fd = new FormData();
  fd.append('file', file);
  fd.append('force_llm', document.getElementById('force-llm').checked ? '1' : '0');
  try {
    const r = await fetch('/generate', { method: 'POST', body: fd });
    const data = await r.json();
    document.getElementById('spinner').style.display = 'none';

    if (data.log) {
      document.getElementById('log').innerHTML = colorLog(data.log);
      document.getElementById('log-box').style.display = 'block';
      document.getElementById('log-box').open = true;
    }

    if (data.error) {
      document.getElementById('error').textContent = data.error;
      document.getElementById('error').style.display = 'block';
    } else {
      const pipeline = data.pipeline ? ' &nbsp;|&nbsp; Pipeline: <b>' + data.pipeline + '</b>' : '';
      document.getElementById('info').innerHTML =
        '<b>Hoan thanh!</b> &nbsp;|&nbsp; Entities: <b>' + data.entities +
        '</b> &nbsp;|&nbsp; Relationships: <b>' + data.relationships + '</b>' + pipeline;
      document.getElementById('drawio-link').href = data.view_url;
      document.getElementById('result').style.display = 'block';
    }
  } catch(err) {
    document.getElementById('spinner').style.display = 'none';
    document.getElementById('error').textContent = 'Loi ket noi: ' + err;
    document.getElementById('error').style.display = 'block';
  }
};
</script>
</body>
</html>"""


@app.get("/", response_class=HTMLResponse)
def index():
    return HTML


@app.post("/generate")
async def generate(file: UploadFile = File(...), force_llm: str = Form("0")):
    try:
        # Luu vao file tam de tranh xung dot voi file dang mo trong Excel
        upload_path = WORK_DIR / "_cdm_upload_temp.xlsx"
        with open(upload_path, "wb") as f:
            shutil.copyfileobj(file.file, f)
    except Exception as exc:
        return JSONResponse({"error": f"Khong luu duoc file: {exc}"}, status_code=400)

    try:
        # Chay pipeline
        env = {**os.environ, "PYTHONIOENCODING": "utf-8"}
        if force_llm in ("1", "true", "yes"):
            env["CDM_FORCE_LLM"] = "1"
        result = subprocess.run(
            [PYTHON, "generate_cdm.py", str(upload_path)],
            cwd=WORK_DIR,
            capture_output=True,
            text=True,
            encoding="utf-8",
            env=env,
            timeout=180,
        )
        log = (result.stdout + ("\n[STDERR]\n" + result.stderr if result.stderr.strip() else "")).strip()

        if result.returncode != 0:
            return JSONResponse({"error": (result.stderr or result.stdout or "Unknown error").strip(), "log": log})

        # Doc so lieu tu output
        entities = relationships = 0
        pipeline = "rule-based"
        for line in result.stdout.splitlines():
            if line.startswith("Entities:"):
                entities = int(line.split(":")[1].strip())
            elif line.startswith("Relationships:"):
                relationships = int(line.split(":")[1].strip())
            elif "[LLM CDM] Calling" in line or "[LLM CDM] Context:" in line:
                pipeline = "LLM"
            elif "[CDM] Using cdm_config" in line:
                pipeline = "cdm_config.json"

        if not OUTPUT_FILE.exists():
            return JSONResponse({"error": "CDM file not generated", "log": log})

        view_url = _drawio_url(OUTPUT_FILE)

        return JSONResponse({
            "entities": entities,
            "relationships": relationships,
            "pipeline": pipeline,
            "view_url": view_url,
            "log": log,
        })

    except subprocess.TimeoutExpired:
        return JSONResponse({"error": "Timeout: pipeline chay qua 180s"})
    except Exception as exc:
        return JSONResponse({"error": f"Loi server: {exc}"})
    finally:
        # Don dep file upload (giu lai neu la Book1.xlsx)
        try:
            if upload_path.exists():
                upload_path.unlink()
        except Exception:
            pass


@app.get("/download")
def download():
    if not OUTPUT_FILE.exists():
        return JSONResponse({"error": "Chua co file CDM"}, status_code=404)
    return FileResponse(
        OUTPUT_FILE,
        media_type="application/octet-stream",
        filename="cdm.drawio",
    )


@app.get("/download/claude")
def download_claude():
    if not CLAUDE_FILE.exists():
        return JSONResponse({"error": "Chua co file Claude CDM. Chay: python gen_claude_cdm.py"}, status_code=404)
    return FileResponse(
        CLAUDE_FILE,
        media_type="application/octet-stream",
        filename="claude_cdm.drawio",
    )


def _drawio_payload(xml: str) -> str:
    """Tạo payload theo chuẩn draw.io '#R': encodeURIComponent -> deflateRaw -> base64.

    Đây là format mxUtils.compress mà draw.io dùng để load diagram từ URL.
    Nén giúp URL ngắn ~5 lần so với base64 thuần (90KB XML -> ~20KB URL)."""
    encoded = urllib.parse.quote(xml, safe="!*'()")          # ~ encodeURIComponent
    compressor = zlib.compressobj(9, zlib.DEFLATED, -15)      # raw deflate (no header)
    compressed = compressor.compress(encoded.encode("utf-8")) + compressor.flush()
    return base64.b64encode(compressed).decode("ascii")

def _drawio_url(path: Path):
    """URL mở trong tab mới — app.diagrams.net (editor đầy đủ)."""
    payload = _drawio_payload(path.read_text(encoding="utf-8"))
    return f"https://app.diagrams.net/#R{urllib.parse.quote(payload)}"

def _drawio_embed_url(path: Path):
    """URL nhúng iframe — viewer.diagrams.net (không bị X-Frame-Options)."""
    payload = _drawio_payload(path.read_text(encoding="utf-8"))
    return f"https://viewer.diagrams.net/?lightbox=0&highlight=0000ff#R{urllib.parse.quote(payload)}"


@app.get("/view/current")
def view_current():
    from fastapi.responses import RedirectResponse
    if not OUTPUT_FILE.exists():
        return JSONResponse({"error": "Chua co file CDM. Upload file Excel de sinh CDM truoc."}, status_code=404)
    return RedirectResponse(_drawio_url(OUTPUT_FILE))


@app.get("/view/claude")
def view_claude():
    from fastapi.responses import RedirectResponse
    if not CLAUDE_FILE.exists():
        return JSONResponse({"error": "Chua co file Claude CDM. Chay: python gen_claude_cdm.py"}, status_code=404)
    return RedirectResponse(_drawio_url(CLAUDE_FILE))


COMPARE_HTML = """<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>So sanh CDM</title>
<style>
  body { font-family: Segoe UI, sans-serif; margin: 0; background: #f0f4f8; }
  header { background: #1a6e2e; color: #fff; padding: 16px 28px; display: flex; align-items: center; gap: 20px; }
  header h1 { margin: 0; font-size: 20px; }
  .panels { display: flex; height: calc(100vh - 60px); }
  .panel { flex: 1; display: flex; flex-direction: column; border-right: 2px solid #c8e6c9; }
  .panel:last-child { border-right: none; }
  .panel-header { background: #2e7d32; color: #fff; padding: 10px 16px; font-weight: 600; font-size: 15px;
                  display: flex; justify-content: space-between; align-items: center; }
  .panel-header a { color: #a5d6a7; font-size: 13px; text-decoration: none; }
  .panel-header a:hover { color: #fff; }
  iframe { flex: 1; border: none; background: #fff; }
  .placeholder { flex: 1; display: flex; align-items: center; justify-content: center;
                 flex-direction: column; color: #555; gap: 12px; background: #fafafa; }
  .placeholder a { background: #1a6e2e; color: #fff; padding: 10px 20px; border-radius: 6px;
                   text-decoration: none; font-weight: 600; }
  .open-btn { display:block; text-align:center; background:#1565c0; color:#fff; padding:7px 14px;
              font-size:13px; text-decoration:none; font-weight:600; }
  .open-btn:hover { background:#0d47a1; }
</style>
</head>
<body>
<header>
  <h1>So sanh CDM: Hien tai vs Claude</h1>
  <span style="font-size:13px;opacity:.8">Xem song song 2 phien ban CDM trong draw.io</span>
</header>
<div class="panels">
  <div class="panel">
    <div class="panel-header">
      CDM Hien tai (GPT / rule-based)
      <a href="/download" title="Tai file">&#8595; Tai .drawio</a>
    </div>
    {CURRENT_EXTRA}
    {CURRENT_CONTENT}
  </div>
  <div class="panel">
    <div class="panel-header">
      Claude CDM (8 domain, 32 entity)
      <a href="/download/claude" title="Tai file">&#8595; Tai .drawio</a>
    </div>
    {CLAUDE_EXTRA}
    {CLAUDE_CONTENT}
  </div>
</div>
</body>
</html>"""


@app.get("/raw/current")
def raw_current():
    from fastapi.responses import Response
    if not OUTPUT_FILE.exists():
        return JSONResponse({"error": "Chua co file CDM"}, status_code=404)
    return Response(OUTPUT_FILE.read_text(encoding="utf-8"), media_type="application/xml")

@app.get("/raw/claude")
def raw_claude():
    from fastapi.responses import Response
    if not CLAUDE_FILE.exists():
        return JSONResponse({"error": "Chua co file Claude CDM"}, status_code=404)
    return Response(CLAUDE_FILE.read_text(encoding="utf-8"), media_type="application/xml")


@app.get("/compare", response_class=HTMLResponse)
def compare():
    if OUTPUT_FILE.exists():
        url = _drawio_embed_url(OUTPUT_FILE)
        open_url = _drawio_url(OUTPUT_FILE)
        current_block = f'<iframe src="{url}" allow="fullscreen"></iframe>'
        current_extra = f'<a href="{open_url}" target="_blank" class="open-btn">Mo trong draw.io editor</a>'
    else:
        current_block = ('<div class="placeholder"><p>Chua co CDM hien tai.</p>'
                         '<a href="/">Upload file Excel</a></div>')
        current_extra = ''

    if CLAUDE_FILE.exists():
        url = _drawio_embed_url(CLAUDE_FILE)
        open_url = _drawio_url(CLAUDE_FILE)
        claude_block = f'<iframe src="{url}" allow="fullscreen"></iframe>'
        claude_extra = f'<a href="{open_url}" target="_blank" class="open-btn">Mo trong draw.io editor</a>'
    else:
        claude_block = ('<div class="placeholder"><p>Chua co Claude CDM.</p>'
                        '<p style="font-size:13px">Chay: <code>python gen_claude_cdm.py</code></p></div>')
        claude_extra = ''

    return (COMPARE_HTML
            .replace("{CURRENT_CONTENT}", current_block)
            .replace("{CURRENT_EXTRA}", current_extra)
            .replace("{CLAUDE_CONTENT}", claude_block)
            .replace("{CLAUDE_EXTRA}", claude_extra))


if __name__ == "__main__":
    import uvicorn
    print("CDM Generator chay tai: http://localhost:8000")
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=False)
