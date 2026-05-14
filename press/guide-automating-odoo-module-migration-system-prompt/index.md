---
name: Guía para automatizar la migración de tus módulos de Odoo entre versiones con este System Prompt
slug: guia-automatizar-migracion-modulos-odoo-system-prompt
status: public
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

Compartimos el System Prompt de código abierto que permite automatizar las reglas de transformación de Odoo. Lo hemos puesto a prueba migrando un módulo extenso desde la versión 12 hasta la 19, superando con éxito todos los *breaking changes* del camino e instalándolo sin errores ni advertencias.

Lo compartimos en código abierto para la comunidad.

---

## 1. El Problema: El 80% es trabajo mecánico

Migrar Odoo cada año es tedioso y costoso. Cada versión rompe decoradores, sintaxis XML y APIs, generando una deuda técnica que paraliza a las empresas.

**La solución:** El System Prompt automatiza ese 80% de tareas repetitivas en minutos. Para garantizar la seguridad, la IA **nunca inventa código**: si hay dudas, marca el bloque con `# TODO AI` para revisión humana. Un simple `grep` permite auditar el resultado en segundos.

---

## 2. Métricas de desempeño

Validamos este sistema con un caso real: un módulo extenso migrado desde **Odoo v12** hasta **Odoo v19** en 7 saltos consecutivos.

**Trayectoria:** `v12 → v13 → v14 → v15 → v16 → v17 → v18 → v19`
**Resultado:** Módulo instalado en Odoo v19 de forma limpia, sin errores ni *warnings*.

### Radiografía del código migrado

| Métrica | Volumen | Detalle |
|:---|:---|:---|
| **Archivos** | 47 | 18 Python, 26 XML, 1 CSV |
| **Líneas de código** | ~5,987 | 1,969 LOC Python, 3,795 LOC XML, 88 LOC CSV |
| **Modelos** | 29 | 23 propios, 6 heredados (`res.partner`, `res.users`, etc.) |
| **Campos** | ~295 | Definiciones completas de modelos |
| **Interfaz y vistas** | 112 | 50 vistas, 26 acciones, 36 menús |
| **Seguridad** | 69 | 69 grupos de seguridad, 87 reglas ACL |

### Stack tecnológico

- **Entorno base:** Odoo 19 + PostgreSQL (Docker Compose).
- **Desarrollo:** Python 3.12+, framework OWL.
- **Motores IA ejecutados:** Claude Code + Claude 3.5 Sonnet / Opus.

---

## 3. Cómo usarlo

Hemos preparado un **workspace** que combina el System Prompt con un entorno de validación listo para migrar y probar tus módulos.

> **Repositorio:** [nodenhq/devx/module-migration](https://github.com/nodenhq/devx/tree/main/module-migration)

### Estructura del workspace
- `CLAUDE.md`: Carga el system prompt automáticamente.
- `.rules/module-migration.md`: Diccionario de reglas completas (v12 → v19).
- `docker-compose.yaml`: Entorno Odoo + PostgreSQL para pruebas rápidas.

### Paso 1 · Preparar el entorno
```bash
cp .env.example .env
mkdir -p src out
```
Copia tu módulo original dentro de `src/`. La variable `ODOO_VERSION` en el `.env` define la versión destino.

### Paso 2 · Lanzar la migración
Abre Claude Code en el directorio y lanza la instrucción:
> *"Migrate `src/mi_modulo` from v12 to v19. Save it in `out/mi_modulo`."*

El agente ejecutará el flujo completo: copiará el código, aplicará las reglas versión por versión y generará un `CHANGELOG.md` con los cambios realizados.

### Paso 3 · Auditoría y corrección
Si la validación automática arroja errores de instalación, pega el *traceback* en Claude Code para que corrija los archivos específicos en `out/`. Finalmente, revisa los puntos manuales:
```bash
grep -rn "TODO AI" out/
```

---

Migrar versiones de Odoo ya no tiene que ser un dolor de cabeza. Al delegar el trabajo manual a la IA, recuperamos tiempo para programar lo que aporta valor real. 

Pruébalo con tus módulos y, si encuentras nuevas reglas, ¡anímate a contribuir al repositorio!

👉 [GitHub: nodenhq/devx/module-migration](https://github.com/nodenhq/devx/tree/main/module-migration)
