# Diseño e implementación de arquitecturas de infraestructura en la nube

El candidato, con experiencia en arquitectura cloud y operaciones, debe diseñar e implementar arquitecturas complejas de Big Data, HPC o Cluster computo en la nube. Los sistemas deben manejar un alto volumen de transacciones (50 000 solicitudes por segundo), garantizar alta disponibilidad (SLA 99.99%) y permitir escalabilidad horizontal. El sistema debe integrarse con servicios de terceros (proveedores de datos, motores de análisis) y cumplir con regulaciones de seguridad y privacidad (GDPR, CCPA). Se espera que el candidato identifique y mitigue riesgos de latencia y consistencia, y proponga soluciones innovadoras para mejorar el rendimiento y la eficiencia.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | manejo, implementación e innovación de infraestructura |
| **Nivel** | senior-l3 |
| **Tipo** | practical |
| **Tiempo estimado** | 4 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Exploración y análisis de requisitos

**Objetivo:** Identificar y documentar los requisitos funcionales y no funcionales del sistema, incluyendo los umbrales de rendimiento y las regulaciones de seguridad y privacidad.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Analiza el dominio de la infraestructura en la nube y enumera los actores, fuentes y sumideros involucrados.
- Identifica los umbrales numéricos del dominio, como el volumen de transacciones y los SLAs.
- Documenta las regulaciones de seguridad y privacidad que deben cumplirse.

**Entregable:** Documento de requisitos funcionales y no funcionales

<details>
<summary>Pistas de conocimiento</summary>

- Considera los diferentes tipos de cargas de trabajo y sus características.
- Investiga las mejores prácticas para la seguridad y privacidad en la nube.

</details>

### Fase 2: Diseño de la arquitectura

**Objetivo:** Diseñar una arquitectura que cumpla con los requisitos identificados, considerando los trade-offs entre consistencia, disponibilidad y partición.

**Tiempo estimado:** 2 semanas

**Instrucciones:**

- Propone una arquitectura que integre servicios de terceros y cumpla con los umbrales de rendimiento y las regulaciones de seguridad y privacidad.
- Identifica y mitiga los riesgos de latencia y consistencia.
- Considera la escalabilidad horizontal y la alta disponibilidad.

**Entregable:** Diagrama de la arquitectura propuesta

<details>
<summary>Pistas de conocimiento</summary>

- Investiga diferentes patrones de arquitectura para Big Data, HPC y Cluster computo.
- Considera el uso de tecnologías como Kafka, MapReduce y Spark.

</details>

### Fase 3: Implementación y validación

**Objetivo:** Implementar la arquitectura propuesta y validar que cumple con los requisitos funcionales y no funcionales.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Implementa la arquitectura utilizando las tecnologías y patrones de arquitectura seleccionados.
- Valida que el sistema cumple con los umbrales de rendimiento y las regulaciones de seguridad y privacidad.
- Realiza pruebas de carga y estrés para asegurar la escalabilidad y la alta disponibilidad.

**Entregable:** Sistema implementado y validado

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de monitoreo y logging para asegurar la visibilidad y la trazabilidad del sistema.
- Considera la automatización de pruebas y despliegues para mejorar la eficiencia y la calidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es una arquitectura de infraestructura en la nube y cuáles son sus componentes principales?
- **paraQueSirve**: ¿Para qué sirve una arquitectura de infraestructura en la nube y cuáles son sus beneficios?
- **comoSeUsa**: ¿Cómo se utiliza una arquitectura de infraestructura en la nube para resolver problemas de Big Data, HPC o Cluster computo?
- **erroresComunes**: ¿Cuáles son los errores comunes al diseñar e implementar una arquitectura de infraestructura en la nube y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el diseño e implementación de una arquitectura de infraestructura en la nube y cómo se pueden justificar?

## Criterios de Evaluacion

- Identificación y documentación de los requisitos funcionales y no funcionales.
- Propuesta de una arquitectura que cumple con los requisitos y mitiga los riesgos.
- Implementación y validación del sistema, asegurando la escalabilidad y la alta disponibilidad.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
