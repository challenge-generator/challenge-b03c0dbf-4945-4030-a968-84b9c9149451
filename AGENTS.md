# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Diseño e implementación de arquitecturas de infraestructura en la nube**.

| | |
|---|---|
| Tema | manejo, implementación e innovación de infraestructura |
| Nivel | senior-l3 |
| Chapter | Cloud Ops |
| Especialidad | AWS |
| Stack | HashiCorp Configuration Language (HCL) / Terraform |
| Patron arquitectonico | modular con landing zone multi-cuenta, segregación de red en capas públicas/privadas, patrones de alta disponibilidad y escalabilidad horizontal para Big Data/HPC |
| Tiempo estimado | 4 semanas |

## Receta del stack

Esqueleto obligatorio:

- `main.tf, variables.tf, outputs.tf y providers.tf en la raiz`
- `modules/ con al menos un modulo propio`
- `environments/{dev,qa,prod}/terraform.tfvars`
- `backend.tf con el estado remoto`
- `README.md con el diagrama de la topologia`

Trampas conocidas:

- `required_version` de Terraform se declara como RANGO (`>= 1.5`), nunca como version exacta (`= 1.7.0` ni `"1.7.0"`). Pineado exacto, el proyecto no corre con ninguna otra version instalada y el participante no puede ni inicializarlo.
- Lo mismo con los providers: `version = "~> 5.0"`, no una version exacta.
- Cada variable de `variables.tf` lleva su valor en `environments/{env}/terraform.tfvars`, no un `default` en la declaracion.

Dependencias:

- hashicorp/aws ~> 5.0
- hashicorp/kubernetes ~> 2.0
- hashicorp/helm ~> 2.0
- terraform-aws-modules/vpc/aws ~> 3.0
- terraform-aws-modules/eks/aws ~> 19.0
- terraform-aws-modules/security-group/aws ~> 4.0
- AWS Well-Architected Tool n/a

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform validate && terraform fmt -check` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform validate && terraform fmt -check` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Exploración y análisis de requisitos**: Documento de requisitos funcionales y no funcionales
- **Fase 2 — Diseño de la arquitectura**: Diagrama de la arquitectura propuesta
- **Fase 3 — Implementación y validación**: Sistema implementado y validado

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `modules/security/main.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- [ ] `modules/security/variables.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- [ ] `modules/security/outputs.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- [ ] `modules/security/iam_policies.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.

## Lo que falta y tenes que completar

### 1. Archivos que la arquitectura declara (3 de 31)

La propuesta arquitectonica del reto los lista y no llegaron al repo. Crealos con implementacion real, respetando la capa en la que viven:

- [ ] `main.tf`
- [ ] `outputs.tf`
- [ ] `backend.tf`

### Presentes (28)

- `variables.tf`
- `providers.tf`
- `modules/network/variables.tf`
- `modules/compute/variables.tf`
- `modules/storage/variables.tf`
- `modules/security/variables.tf`
- `modules/monitoring/variables.tf`
- `modules/bigdata/variables.tf`
- `modules/network/main.tf`
- `modules/network/outputs.tf`
- `modules/compute/main.tf`
- `modules/compute/outputs.tf`
- `modules/storage/main.tf`
- `modules/storage/outputs.tf`
- `modules/security/main.tf`
- `modules/security/outputs.tf`
- `modules/monitoring/main.tf`
- `modules/monitoring/outputs.tf`
- `modules/bigdata/main.tf`
- `modules/bigdata/outputs.tf`
- `modules/security/iam_policies.tf`
- `modules/bigdata/kinesis.tf`
- `modules/bigdata/kinesis_producer.tf`
- `modules/bigdata/kinesis_consumer.tf`
- `README.md`
- `environments/dev/terraform.tfvars`
- `environments/qa/terraform.tfvars`
- `environments/prod/terraform.tfvars`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `modules`
- `modules/network`
- `modules/compute`
- `modules/storage`
- `modules/security`
- `modules/monitoring`
- `modules/bigdata`
- `environments`
- `environments/dev`
- `environments/qa`
- `environments/prod`

## Verificacion

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con landing zone multi-cuenta, segregación de red en capas públicas/privadas, patrones de alta disponibilidad y escalabilidad horizontal para Big Data/HPC**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Cloud Ops, Especialidad Arquitectura, Tecnología Cloud Infrastructure, Senior
- Brecha que el reto ataca: Diseñar e implementar arquitecturas complejas como Big Data (kafka, Map Reduce, Spark compatibles en Cloud), HPC (High performance compute) o Cluster computo (por ejemplo Placement Group en AWS o alguna otra solución tecnológica).
- Mision: Candidato con experiencia en arquitectura cloud y operaciones.

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
