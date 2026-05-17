---
name: Guide to Automating Odoo Module Migrations with this AI System Prompt
slug: guide-automating-odoo-module-migration-system-prompt
status: published
tags:
  - llm
  - system-prompt
  - migration
  - odoo
  - erp
authors:
  - josehbez
---
![](attachments/cover.png)

We are sharing the open-source System Prompt designed to automate Odoo transformation rules. We put it to the test by migrating an extensive module from version 12 to 19, successfully navigating all *breaking changes* along the way and installing it without errors or warnings.

---

## 1. The Problem: 80% is Mechanical Work

Updating Odoo every year is expensive and repetitive. Each version breaks ORM decorators, XML syntax, and APIs, leading to high costs and paralyzing technical debt.

**The Solution:** This System Prompt automates that 80% of repetitive tasks in minutes. To ensure safety, the AI **never hallucinates code**: if unsure, it adds a `# TODO AI` marker for human review. A simple `grep` allows you to audit the results in seconds.

---

## 2. Performance Metrics: A Real-World Case

We validated this system with a complex module, subjected to a 7-jump trajectory: `v12 → v13 → v14 → v15 → v16 → v17 → v18 → v19`.

**Result:** Clean installation in Odoo v19, meeting all standards of the target environment.

### Codebase Overview

| Metric | Volume | Details |
|:---|:---|:---|
| **Files** | 47 | 18 Python, 26 XML, 1 CSV |
| **Lines of Code** | ~5,987 | 1,969 LOC Python, 3,795 LOC XML |
| **Models** | 29 | 23 custom, 6 inherited (`res.partner`, `res.users`, etc.) |
| **Fields** | ~295 | Full model definitions |
| **UI & Views** | 112 | 50 views, 26 actions, 36 menus |
| **Security** | 69 | 69 security groups, 87 ACL rules |

### Tech Stack
- **Environment:** Odoo 19 + PostgreSQL (Docker Compose).
- **Language:** Python 3.12+ and OWL Framework.
- **AI Engines:** Claude Code + Claude 3.5 Sonnet / Opus.

---

## 3. How to Use It

We have prepared a **workspace** that integrates the System Prompt with a validation environment (Odoo + PostgreSQL) ready to use.

> **Repository:** [nodenhq/devx/module-migration](https://github.com/nodenhq/devx/tree/main/module-migration)

### Workspace Structure
- `CLAUDE.md`: Automatically loads the system prompt.
- `.rules/module-migration.md`: Complete migration rules dictionary (v12 → v19).
- `docker-compose.yaml`: Infrastructure for immediate validation.

### Step 1 · Environment Setup
```bash
cp .env.example .env
mkdir -p src out
```
Place your original module inside `src/`. The `ODOO_VERSION` variable in `.env` determines the target version.

### Step 2 · Run the Migration
Open Claude Code in the directory and issue the instruction:
> *"Migrate `src/my_module` from v12 to v19. Save it in `out/my_module`."*

The agent will execute the full workflow: copy the code, apply rules version by version, and generate a detailed `CHANGELOG.md`.

### Step 3 · Audit and Correction
If the automatic validation throws installation errors, paste the *traceback* back into Claude Code. The agent will identify affected files in `out/` and apply fixes without touching the rest of the work. Finally, review manual points with:
```bash
grep -rn "TODO AI" out/
```

---

Odoo migrations don’t have to be a headache anymore. By delegating the manual work to AI, we reclaim our time to code what truly matters. 

Give it a try with your modules and, if you discover new rules, feel free to contribute to the repo!

👉 [GitHub: nodenhq/devx/module-migration](https://github.com/nodenhq/devx/tree/main/module-migration)
