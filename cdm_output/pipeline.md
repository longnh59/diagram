# CDM Agent Pipeline

This folder is generated from `Book1.xlsx` and follows the requested seven-agent flow.

| Step | Agent | Output | Purpose |
| --- | --- | --- | --- |
| 1 | Metadata Extractor | `metadata_extraction.json` | Raw tables, columns, keys, descriptions, relationships |
| 2 | Table Classifier | `table_classifier.md` | Physical table class: core, event, extension, asset, organization |
| 3 | Business Entity Grouper | `business_entity_groups.md` | Collapsed business entities from one or more physical tables |
| 4 | Relationship Simplifier | `relationship_simplification.md` | Conceptual vs implementation relationships |
| 5 | Subject Area Mapper | `domain_map.md` | Subject areas/domains and table coverage |
| 6 | Conceptual Model Generator | `cdm.md`, `cdm_erd.mmd`, `cdm.drawio`, `glossary.md` | CDM, Mermaid, Draw.io, glossary |
| 7 | Reviewer / Human Approval | `reviewer_approval.md` | Open decisions and approval checklist |

Current run summary:
- Tables retained: 83
- Business entities: 34
- Relationships: 63
- Dropped duplicate mixed-case tables: 8
