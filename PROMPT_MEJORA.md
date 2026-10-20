# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `modules/security/main.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- `modules/security/variables.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- `modules/security/outputs.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.
- `modules/security/iam_policies.tf` — El topic pide autenticacion/seguridad: este archivo es el ejercicio.

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Archivos que la arquitectura del reto declara y no estan

Creálos con implementacion real, en la capa que les corresponde:

- `main.tf`
- `outputs.tf`
- `backend.tf`

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Arquitectura, Tecnología Cloud Infrastructure, Senior

### Brecha de conocimiento
Diseñar e implementar arquitecturas complejas como Big Data (kafka, Map Reduce, Spark compatibles en Cloud), HPC (High performance compute) o Cluster computo (por ejemplo Placement Group en AWS o alguna otra solución tecnológica).

### Misión / candidato
Candidato con experiencia en arquitectura cloud y operaciones.

### Reto
- Tema: manejo, implementación e innovación de infraestructura
- Seniority: senior-l3
- Tipo: practical
- Título: Diseño e implementación de arquitecturas de infraestructura en la nube
- Tiempo estimado: 4 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Exploración y análisis de requisitos — objetivo: Identificar y documentar los requisitos funcionales y no funcionales del sistema, incluyendo los umbrales de rendimiento y las regulaciones de seguridad y privacidad. — entregable (NO resolver): Documento de requisitos funcionales y no funcionales
- Fase 2: Diseño de la arquitectura — objetivo: Diseñar una arquitectura que cumpla con los requisitos identificados, considerando los trade-offs entre consistencia, disponibilidad y partición. — entregable (NO resolver): Diagrama de la arquitectura propuesta
- Fase 3: Implementación y validación — objetivo: Implementar la arquitectura propuesta y validar que cumple con los requisitos funcionales y no funcionales. — entregable (NO resolver): Sistema implementado y validado

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
# Declaración de variables globales para parametrizar la infraestructura
has	la capacidad de ser reutilizadas por todos los módulos.

variable "region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado consistente de recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes de bases de datos"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "eks_cluster_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
}

variable "eks_node_instance_type" {
  description = "Tipo de instancia para los nodos del cluster EKS"
  type        = string
}

variable "eks_node_min_size" {
  description = "Número mínimo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_max_size" {
  description = "Número máximo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_desired_size" {
  description = "Número deseado de nodos en el grupo de auto-scaling"
  type        = number
}

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenamiento de datos"
  type        = string
}

variable "s3_storage_class" {
  description = "Clase de almacenamiento para objetos en S3 (STANDARD, INFREQUENT_ACCESS, etc.)"
  type        = string
  default     = "STANDARD"
}

variable "kinesis_stream_name" {
  description = "Nombre del stream Kinesis para procesamiento de datos en tiempo real"
  type        = string
}

variable "kinesis_shard_count" {
  description = "Número de shards para el stream Kinesis"
  type        = number
}

variable "rds_instance_class" {
  description = "Clase de instancia para RDS"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
}

variable "rds_engine_version" {
  description = "Versión del motor de base de datos para RDS"
  type        = string
}

variable "rds_multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS"
  type        = bool
  default     = true
}

variable "cloudwatch_log_retention" {
  description = "Días de retención para logs en CloudWatch"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: providers.tf ===
# Configuración de proveedores y versiones requeridas

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = module.compute.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.compute.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = module.compute.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.compute.eks_cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_name
}

// === ARCHIVO: modules/network/variables.tf ===
# Variables para el módulo de red (VPC, subredes, NAT gateways, etc.)

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC principal"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes privadas"
  type        = list(string)
}

variable "database_subnet_cidrs" {
  description = "Lista de bloques CIDR para subredes de bases de datos"
  type        = list(string)
}

variable "azs" {
  description = "Lista de zonas de disponibilidad para distribuir subredes"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subredes privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un único NAT Gateway para todas las subredes privadas"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Crear un NAT Gateway por zona de disponibilidad"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Habilitar nombres de host DNS en la VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Habilitar soporte DNS en la VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/compute/variables.tf ===
# Variables para el módulo de cómputo (EKS, auto-scaling, etc.)

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  type        = string
}

variable "eks_cluster_version" {
  description = "Versión de Kubernetes para el cluster EKS"
  type        = string
}

variable "eks_node_instance_type" {
  description = "Tipo de instancia para los nodos del cluster EKS"
  type        = string
}

variable "eks_node_min_size" {
  description = "Número mínimo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_max_size" {
  description = "Número máximo de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_node_desired_size" {
  description = "Número deseado de nodos en el grupo de auto-scaling"
  type        = number
}

variable "eks_subnet_ids" {
  description = "IDs de las subredes donde se desplegarán los nodos del cluster EKS"
  type        = list(string)
}

variable "eks_cluster_endpoint_private_access" {
  description = "Habilitar acceso privado al endpoint del cluster EKS"
  type        = bool
  default     = true
}

variable "eks_cluster_endpoint_public_access" {
  description = "Habilitar acceso público al endpoint del cluster EKS"
  type        = bool
  default     = false
}

variable "eks_cluster_enabled_log_types" {
  description = "Tipos de logs habilitados para el cluster EKS"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/storage/variables.tf ===
# Variables para el módulo de almacenamiento (S3, EFS, etc.)

variable "s3_bucket_name" {
  description = "Nombre del bucket S3 para almacenamiento de datos"
  type        = string
}

variable "s3_storage_class" {
  description = "Clase de almacenamiento para objetos en S3 (STANDARD, INFREQUENT_ACCESS, etc.)"
  type        = string
  default     = "STANDARD"
}

variable "s3_versioning" {
  description = "Habilitar versionado en el bucket S3"
  type        = bool
  default     = true
}

variable "s3_server_side_encryption" {
  description = "Habilitar cifrado del lado del servidor para el bucket S3"
  type        = bool
  default     = true
}

variable "s3_block_public_access" {
  description = "Bloquear acceso público al bucket S3"
  type        = bool
  default     = true
}

variable "kinesis_stream_name" {
  description = "Nombre del stream Kinesis para procesamiento de datos en tiempo real"
  type        = string
}

variable "kinesis_shard_count" {
  description = "Número de shards para el stream Kinesis"
  type        = number
}

variable "efs_creation_token" {
  description = "Token de creación para el sistema de archivos EFS"
  type        = string
  default     = ""
}

variable "efs_performance_mode" {
  description = "Modo de rendimiento para EFS (generalPurpose o maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "efs_throughput_mode" {
  description = "Modo de throughput para EFS (bursting o provisioned)"
  type        = string
  default     = "bursting"
}

variable "efs_provisioned_throughput_in_mibps" {
  description = "Throughput provisionado para EFS en MiB/s (solo si throughput_mode = "provisioned")"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/security/variables.tf ===
# Variables para el módulo de seguridad (IAM, políticas de acceso, etc.)
# Superficie de práctica: los valores se definirán en los archivos de implementación
del módulo.

variable "iam_role_name" {
  description = "Nombre del rol IAM para servicios y aplicaciones"
  type        = string
}

variable "iam_policy_arns" {
  description = "ARNs de políticas IAM a adjuntar al rol"
  type        = list(string)
  default     = []
}

variable "eks_cluster_name" {
  description = "Nombre del cluster EKS para asociar roles y políticas"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN del bucket S3 para políticas de acceso"
  type        = string
}

variable "kinesis_stream_arn" {
  description = "ARN del stream Kinesis para políticas de acceso"
  type        = string
}

variable "rds_instance_arn" {
  description = "ARN de la instancia RDS para políticas de acceso"
  type        = string
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos del módulo"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/monitoring/variables.tf ===
variable "environment" {
  description = "Nombre del ambiente (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS donde se desplegará el módulo de monitoreo"
  type        = string
}

variable "alarm_thresholds" {
  description = "Umbrales de alarmas para métricas críticas del sistema"
  type = object({
    cpu_utilization_high    = number
    cpu_utilization_low     = number
    memory_utilization_high = number
    memory_utilization_low  = number
    disk_utilization_high   = number
    network_in_high         = number
    network_out_high        = number
    latency_p99_high        = number
    error_rate_high         = number
    request_count_threshold = number
  })
}

variable "dashboard_widgets" {
  description = "Configuración de widgets para el dashboard de CloudWatch"
  type = list(object({
    type       = string
    title      = string
    width      = number
    height     = number
    properties = map(any)
  }))
  default = []
}

variable "log_groups" {
  description = "Grupos de logs a monitorear"
  type = list(object({
    name              = string
    retention_days    = number
    kms_key_arn       = optional(string)
    tags              = map(string)
  }))
}

variable "metrics_to_collect" {
  description = "Lista de métricas personalizadas a recopilar"
  type = list(string)
  default = ["CustomMetric1", "CustomMetric2", "CustomMetric3"]
}

variable "alarm_actions" {
  description = "ARNs de SNS para notificaciones de alarmas"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "ARNs de SNS para notificaciones cuando la alarma se resuelve"
  type        = list(string)
  default     = []
}

variable "evaluation_periods" {
  description = "Número de períodos de evaluación para las alarmas"
  type        = number
  default     = 3
}

variable "period_seconds" {
  description = "Período en segundos para la evaluación de métricas"
  type        = number
  default     = 300
}

variable "datapoints_to_alarm" {
  description = "Número de datapoints que deben violar el umbral para activar la alarma"
  type        = number
  default     = 2
}

variable "treat_missing_data" {
  description = "Cómo tratar los datos faltantes en las métricas"
  type        = string
  default     = "notBreaching"
}

variable "enable_composite_alarm" {
  description = "Habilitar alarma compuesta que agregue múltiples métricas"
  type        = bool
  default     = true
}

variable "composite_alarm_name" {
  description = "Nombre de la alarma compuesta"
  type        = string
  default     = "CompositeAlarm"
}

variable "create_anomaly_detection" {
  description = "Habilitar detección de anomalías para métricas seleccionadas"
  type        = bool
  default     = false
}

variable "anomaly_detection_baseline" {
  description = "Configuración de línea base para detección de anomalías"
  type = object({
    metric_name     = string
    namespace       = string
    stat            = string
    hours_of_data   = number
  })
  default = null
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de monitoreo"
  type        = map(string)
  default     = {}
}

variable "enable_detailed_monitoring" {
  description = "Habilitar monitoreo detallado para instancias EC2"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Intervalo de colección de métricas en segundos"
  type        = number
  default     = 60
}

variable "custom_namespace" {
  description = "Namespace personalizado para métricas de aplicación"
  type        = string
  default     = "CustomApplication"
}

variable "enable_canary_monitoring" {
  description = "Habilitar monitoreo de sinteticos (canaries) para endpoints"
  type        = bool
  default     = false
}

variable "canary_configs" {
  description = "Configuración de canaries de CloudWatch Synthetics"
  type = list(object({
    name           = string
    schedule_type  = string
    schedule_value = string
    runtime_version = string
    timeout_seconds = number
  }))
  default = []
}

variable "enable_insight_rules" {
  description = "Habilitar CloudWatch Application Insights para detección automática de problemas"
  type        = bool
  default     = false
}

variable "insight_rules_resources" {
  description = "Recursos a monitorear con Application Insights"
  type        = list(string)
  default     = []
}

// === ARCHIVO: modules/bigdata/variables.tf ===
variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para identificación de recursos"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el módulo de Big Data"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subredes donde se desplegarán los recursos de Big Data"
  type        = list(string)
}

variable "cluster_configuration" {
  description = "Configuración del cluster de procesamiento de datos"
  type = object({
    cluster_type    = string
    instance_type   = string
    instance_count  = number
    master_instance = string
    core_instance   = number
    task_instance   = number
    instance_ebs_size = number
    encrypted       = bool
    termination_protection = bool
    visible_to_all_users = bool
  })
}

variable "emr_version" {
  description = "Versión de EMR a utilizar"
  type        = string
  default     = "emr-7.1.0"
}

variable "applications" {
  description = "Lista de aplicaciones a instalar en el cluster EMR"
  type        = list(string)
  default     = ["Spark", "Hive", "Livy", "JupyterEnterpriseGateway"]
}

variable "bootstrap_actions" {
  description = "Scripts de bootstrap para personalización del cluster"
  type = list(object({
    name = string
    path = string
    args = list(string)
  }))
  default = []
}

variable "steps" {
  description = "Pasos de EMR a ejecutar durante la creación del cluster"
  type = list(object({
    name          = string
    action_on_failure = string
    jar           = string
    main_class    = optional(string)
    args          = list(string)
  }))
  default = []
}

variable "kinesis_configuration" {
  description = "Configuración de Kinesis Data Streams"
  type = object({
    stream_name             = string
    shard_count             = number
    retention_period_hours  = number
    encryption_type         = string
    kms_key_id              = optional(string)
    enhanced_monitoring     = list(string)
  })
}

variable "kinesis_firehose" {
  description = "Configuración de Kinesis Data Firehose"
  type = object({
    name                           = string
    destination                    = string
    s3_bucket_arn                  = string
    s3_prefix                      = optional(string)
    s3_buffer_size                 = number
    s3_buffer_interval             = number
    compression_format             = string
    encryption_enabled             = bool
    kms_key_arn                    = optional(string)
    log_group_name                 = string
  })
  default = null
}

variable "redshift_configuration" {
  description = "Configuración de Redshift para data warehousing"
  type = object({
    cluster_identifier      = string
    database_name           = string
    master_username         = string
    master_password         = string
    node_type               = string
    cluster_type            = number
    encrypted               = bool
    kms_key_id              = optional(string)
    enhanced_vpc_routing    = bool
    publicly_accessible     = bool
    skip_final_snapshot     = bool
    final_snapshot_name     = optional(string)
    automated_snapshot_retention_days = number
    manual_snapshot_retention_days    = number
    port                    = number
  })
  default = null
}

variable "s3_data_lake" {
  description = "Configuración del Data Lake en S3"
  type = object({
    bucket_name             = string
    versioning_enabled      = bool
    server_side_encryption  = string
    kms_key_arn             = optional(string)
    lifecycle_rules = list(object({
      id      = string
      status  = string
      transition = list(object({
        days          = number
        storage_class = string
      }))
    }))
    cross_region_replication = bool
    replication_role_arn    = optional(string)
  })
}

variable "glue_configuration" {
  description = "Configuración de AWS Glue para ETL"
  type = object({
    glue_version      = string
    worker_type       = number
    number_of_workers = number
    max_capacity      = optional(number)
    catalog_id        = optional(string)
    database_name     = string
    table_prefix      = optional(string)
  })
  default = null
}

variable "athena_configuration" {
  description = "Configuración de Athena para consultas SQL sobre S3"
  type = object({
    workgroup_name    = string
    description       = string
    engine_version    = string
    output_location   = string
    encryption_option = string
    kms_key_arn       = optional(string)
  })
  default = null
}

variable "security_configuration" {
  description = "Configuración de seguridad para Big Data"
  type = object({
    enable_vpc_endpoint       = bool
    enable_private_dns        = bool
    enable_cloudtrail         = bool
    enable_access_logs        = bool
    access_logs_bucket        = optional(string)
    enable_macie              = bool
    macie_frequency           = optional(string)
    enable_guardduty          = bool
    guardduty_frequency       = optional(string)
  })
}

variable "auto_scaling" {
  description = "Configuración de auto scaling para el cluster"
  type = object({
    enable_auto_scaling    = bool
    min_capacity           = number
    max_capacity           = number
    scaling_adjustment     = number
    cooldown_period        = number
    metric_type            = string
    target_value           = number
  })
  default = null
}

variable "logging_configuration" {
  description = "Configuración de logging para componentes de Big Data"
  type = object({
    enable_emr_logging    = bool
    emr_log_bucket        = optional(string)
    enable_s3_access_log  = bool
    s3_access_log_bucket  = optional(string)
    log_expiration_days   = number
  })
}

variable "backup_configuration" {
  description = "Configuración de backups para datos críticos"
  type = object({
    enable_backup          = bool
    backup_schedule        = string
    retention_days         = number
    backup_destination     = string
    backup kms_key_arn     = optional(string)
  })
  default = null
}

variable "tags" {
  description = "Etiquetas personalizadas para recursos de Big Data"
  type        = map(string)
  default     = {}
}

variable "enable_monitoring" {
  description = "Habilitar monitoreo detallado del cluster"
  type        = bool
  default     = true
}

variable "notifications" {
  description = "Configuración de notificaciones SNS"
  type = object({
    enable_notifications = bool
    notification_types   = list(string)
    sns_topic_arn        = optional(string)
  })
}

// === ARCHIVO: modules/network/main.tf ===
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  vpc_cidr = var.vpc_cidr
  azs     = data.aws_availability_zones.available.names

  public_subnet_cidrs  = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, i)]
  private_subnet_cidrs = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, var.availability_zones_count + i)]
  database_subnet_cidrs = [for i in range(var.availability_zones_count) : cidrsubnet(local.vpc_cidr, 4, (var.availability_zones_count * 2) + i)]

  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpc"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-igw"
  })
}

resource "aws_subnet" "public" {
  count = var.availability_zones_count

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnet_cidrs[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-subnet-${count.index + 1}"
    Type = "Public"
  })
}

resource "aws_subnet" "private" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-subnet-${count.index + 1}"
    Type = "Private"
  })
}

resource "aws_subnet" "database" {
  count = var.availability_zones_count

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.database_subnet_cidrs[count.index]
  availability_zone = local.azs[count.index]

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-database-subnet-${count.index + 1}"
    Type = "Database"
  })
}

resource "aws_eip" "nat" {
  count = var.availability_zones_count

  domain = "vpc"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-eip-nat-${count.index + 1}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  count = var.availability_zones_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-nat-gw-${count.index + 1}"
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-rt"
  })
}

resource "aws_route_table" "private" {
  count = var.availability_zones_count

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-rt-${count.index + 1}"
  })
}

resource "aws_route_table_association" "public" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "database" {
  count = var.availability_zones_count

  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.s3"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-s3"
  })
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.dynamodb"

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-dynamodb"
  })
}

resource "aws_vpc_endpoint" "ec2" {
  count = var.enable_private_endpoints.ec2 ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ec2"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ec2"
  })
}

resource "aws_vpc_endpoint" "ecr_api" {
  count = var.enable_private_endpoints.ecr_api ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ecr-api"
  })
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.enable_private_endpoints.ecr_dkr ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ecr-dkr"
  })
}

resource "aws_vpc_endpoint" "logs" {
  count = var.enable_private_endpoints.logs ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.logs"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-logs"
  })
}

resource "aws_vpc_endpoint" "ssm" {
  count = var.enable_private_endpoints.ssm ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ssm"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-ssm"
  })
}

resource "aws_vpc_endpoint" "secretsmanager" {
  count = var.enable_private_endpoints.secretsmanager ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.secretsmanager"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-secretsmanager"
  })
}

resource "aws_vpc_endpoint" "sqs" {
  count = var.enable_private_endpoints.sqs ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.sqs"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-sqs"
  })
}

resource "aws_vpc_endpoint" "kinesis_firehose" {
  count = var.enable_private_endpoints.kinesis_firehose ? 1 : 0

  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.kinesis-firehose"

  private_dns_enabled = var.enable_private_dns

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-kinesis-firehose"
  })
}

resource "aws_security_group" "vpc_endpoints" {
  name        = "${local.name_prefix}-vpce-sg"
  description = "Security group for VPC endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "Allow HTTPS from within VPC"
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound HTTPS"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpce-security-group"
  })
}

resource "aws_flow_log" "vpc_flow_logs" {
  count = var.enable_vpc_flow_logs ? 1 : 0

  log_destination      = var.flow_log_destination
  log_destination_type = var.flow_log_destination_type
  traffic_type         = var.flow_log_traffic_type
  vpc_id               = aws_vpc.main.id

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpc-flow-logs"
  })
}

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.public[*].id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-public-nacl"
  })
}

resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = aws_vpc.main.cidr_block
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-private-nacl"
  })
}


// === ARCHIVO: modules/network/outputs.tf ===
output "vpc_id" {
  description = "ID de la VPC principal"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "vpc_default_security_group_id" {
  description = "ID del grupo de seguridad por defecto de la VPC"
  value       = module.vpc.default_security_group_id
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = module.vpc.private_subnets
}

output "database_subnet_ids" {
  description = "IDs de las subredes de base de datos"
  value       = module.vpc.database_subnets
}

output "redshift_subnet_ids" {
  description = "IDs de las subredes para Redshift"
  value       = module.vpc.redshift_subnets
}

output "elasticache_subnet_ids" {
  description = "IDs de las subredes para ElastiCache"
  value       = module.vpc.elasticache_subnets
}

output "intra_subnet_ids" {
  description = "IDs de las subredes intra (sin acceso a internet)"
  value       = module.vpc.intra_subnets
}

output "nat_gateway_ips" {
  description = "IPs de los NAT Gateways"
  value       = module.vpc.nat_gateway_ips
}

output "nat_gateway_ids" {
  description = "IDs de los NAT Gateways"
  value       = module.vpc.nat_gateway_ids
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = module.vpc.igw_id
}

output "public_route_table_ids" {
  description = "IDs de las tablas de rutas públicas"
  value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "IDs de las tablas de rutas privadas"
  value       = module.vpc.private_route_table_ids
}

output "database_route_table_ids" {
  description = "IDs de las tablas de rutas de base de datos"
  value       = module.vpc.database_route_table_ids
}

output "vpc_primary_cidr_block" {
  description = "Bloque CIDR primario de la VPC"
  value       = module.vpc.vpc_primary_cidr_block
}

output "vpc_secondary_cidr_blocks" {
  description = "Bloques CIDR secundarios de la VPC (CIDR blocks adicionales)"
  value       = module.vpc.vpc_secondary_cidr_blocks
}

output "azs" {
  description = "Zonas de disponibilidad configuradas"
  value       = module.vpc.azs
}

output "name_prefix" {
  description = "Prefijo de nombre usado para los recursos"
  value       = var.name_prefix
}

output "tags" {
  description = "Etiquetas aplicadas a todos los recursos"
  value       = var.tags
}

output "vpc_enable_dns_hostnames" {
  description = "Indica si los hostnames DNS están habilitados"
  value       = module.vpc.enable_dns_hostnames
}

output "vpc_enable_dns_support" {
  description = "Indica si el soporte DNS está habilitado"
  value       = module.vpc.enable_dns_support
}

// === ARCHIVO: modules/compute/main.tf ===
locals {
  compute_tags = merge(
    var.tags,
    {
      "Component" = "compute"
      "Environment" = var.environment
    }
  )
}

# Módulo EKS Cluster principal para Big Data
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.kubernetes_version

  vpc_id                         = var.vpc_id
  subnet_ids                     = var.private_subnet_ids
  cluster_endpoint_public_access = var.eks_endpoint_public_access

  eks_managed_node_group_defaults = {
    ami_type       = var.eks_node_ami_type
    instance_types = var.eks_instance_types
  }

  eks_managed_node_groups = var.eks_node_groups

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  enable_cluster_encryption = true
  cluster_encryption_config = [
    {
      provider_key_arn = var.kms_key_arn
      resources        = ["secrets"]
    }
  ]

  tags = local.compute_tags
}

# Grupo de Placement para HPC cuando se requiere baja latencia
resource "aws_placement_group" "hpc_placement_group" {
  count = var.enable_hpc && var.hpc_placement_group_strategy != "" ? 1 : 0

  name     = "${var.name_prefix}-hpc-${var.environment}"
  strategy = var.hpc_placement_group_strategy

  tags = local.compute_tags
}

# Auto Scaling Group para instancias de cómputo adicionales
resource "aws_launch_template" "compute_lt" {
  count = var.enable_autoscaling ? 1 : 0

  name_prefix   = "${var.name_prefix}-compute-lt-"
  image_id      = var.compute_instance_ami
  instance_type = var.compute_instance_type

  ebs_optimized = var.compute_ebs_optimized

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.compute_root_volume_size
      volume_type = var.compute_root_volume_type
      encrypted   = true
      kms_key_id  = var.kms_key_arn
    }
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"
    tags          = local.compute_tags
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${var.ecs_cluster_name}" >> /etc/ecs/ecs.config
              EOF
            )

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.compute_tags
  }
}

resource "aws_autoscaling_group" "compute_asg" {
  count = var.enable_autoscaling ? 1 : 0

  name                = "${var.name_prefix}-compute-asg-${var.environment}"
  vpc_zone_identifier = var.private_subnet_ids
  desired_capacity    = var.compute_desired_capacity
  min_size            = var.compute_min_size
  max_size            = var.compute_max_size
  health_check_type   = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.compute_lt[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-compute-node-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Component"
    value               = "compute"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Políticas IAM para el rol del nodo EKS
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = each.value.node_role_name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = each.value.node_role_name
}

resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = each.value.node_role_name
}

# Security Group para el cluster EKS
module "eks_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${var.name_prefix}-eks-${var.environment}"
  description = "Security group for EKS cluster ${var.eks_cluster_name}"
  vpc_id      = var.vpc_id

  ingress_rules = [
    { from_port = 443, to_port = 443, protocol = "tcp", description = "Kubernetes API" },
    { from_port = 10250, to_port = 10250, protocol = "tcp", description = "Kubelet API" },
  ]

  egress_rules = ["all-all"]

  tags = local.compute_tags
}

# ECS Cluster para cargas de trabajo de contenedores
resource "aws_ecs_cluster" "main" {
  count = var.enable_ecs ? 1 : 0

  name = var.ecs_cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  tags = local.compute_tags
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  count = var.enable_ecs ? 1 : 0

  cluster_name = aws_ecs_cluster.main[0].name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

// === ARCHIVO: modules/compute/outputs.tf ===
output "eks_cluster_name" {
  description = "Nombre del cluster EKS"
  value       = module.eks.cluster_name
}

output "eks_cluster_id" {
  description = "ID del cluster EKS"
  value       = module.eks.cluster_id
}

output "eks_cluster_arn" {
  description = "ARN del cluster EKS"
  value       = module.eks.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "Endpoint del cluster EKS"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Datos del certificado CA del cluster EKS"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "eks_oidc_provider_arn" {
  description = "ARN del proveedor OIDC del cluster EKS"
  value       = module.eks.oidc_provider_arn
}

output "eks_oidc_provider_url" {
  description = "URL del proveedor OIDC del cluster EKS"
  value       = module.eks.oidc_provider_url
}

output "eks_security_group_id" {
  description = "ID del security group del cluster EKS"
  value       = module.eks_security_group.security_group_id
}

output "eks_node_group_arns" {
  description = "ARNs de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_arn }
}

output "eks_node_group_ids" {
  description = "IDs de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_id }
}

output "eks_node_group_statuses" {
  description = "Estados de los node groups del cluster EKS"
  value       = { for k, v in module.eks.eks_managed_node_groups : k => v.node_group_status }
}

output "eks_node_role_arn" {
  description = "ARN del rol de los nodos EKS"
  value       = values(module.eks.eks_managed_node_groups)[0].node_role_arn
}

output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].id : null
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].arn : null
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = var.enable_ecs ? aws_ecs_cluster.main[0].name : null
}

output "autoscaling_group_name" {
  description = "Nombre del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].name : null
}

output "autoscaling_group_id" {
  description = "ID del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].id : null
}

output "autoscaling_group_arn" {
  description = "ARN del Auto Scaling Group de cómputo"
  value       = var.enable_autoscaling ? aws_autoscaling_group.compute_asg[0].arn : null
}

output "launch_template_id" {
  description = "ID del Launch Template para cómputo"
  value       = var.enable_autoscaling ? aws_launch_template.compute_lt[0].id : null
}

output "hpc_placement_group_id" {
  description = "ID del Placement Group para HPC"
  value       = var.enable_hpc && var.hpc_placement_group_strategy != "" ? aws_placement_group.hpc_placement_group[0].id : null
}

output "hpc_placement_group_arn" {
  description = "ARN del Placement Group para HPC"
  value       = var.enable_hpc && var.hpc_placement_group_strategy != "" ? aws_placement_group.hpc_placement_group[0].arn : null
}

output "compute_node_instance_iam_role_arn" {
  description = "ARN del rol IAM para las instancias de cómputo"
  value       = var.enable_autoscaling ? aws_iam_role.compute_node_role[0].arn : null
}


// === ARCHIVO: modules/storage/main.tf ===
# Módulo de almacenamiento para Big Data, HPC y datos estructurados
# Provee S3, EFS, RDS y DynamoDB con cifrado y alta disponibilidad

locals {
  nombre_base = var.nombre_proyecto
  entorno     = var.entorno
  etiquetas   = merge(var.etiquetas_comunes, { Entorno = local.entorno })
}

# Bucket S3 para Big Data - almacenamiento de objetos de alto volumen
resource "aws_s3_bucket" "bigdata" {
  bucket = "${local.nombre_base}-bigdata-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket S3 para datos landing zone - ingestión de datos crudos
resource "aws_s3_bucket" "landing" {
  bucket = "${local.nombre_base}-landing-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "landing" {
  bucket = aws_s3_bucket.landing.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "landing" {
  bucket = aws_s3_bucket.landing.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "landing" {
  bucket = aws_s3_bucket.landing.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Bucket S3 para datos procesados - salida de pipelines
resource "aws_s3_bucket" "procesados" {
  bucket = "${local.nombre_base}-procesados-${local.entorno}"

  tags = local.etiquetas
}

resource "aws_s3_bucket_versioning" "procesados" {
  bucket = aws_s3_bucket.procesados.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "procesados" {
  bucket = aws_s3_bucket.procesados.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.almacenamiento.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "procesados" {
  bucket = aws_s3_bucket.procesados.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Sistema de archivos EFS para HPC - acceso compartido de alta velocidad
resource "aws_efs_file_system" "hpc" {
  creation_token = "${local.nombre_base}-hpc-${local.entorno}"

  encrypted = true
  kms_key_id = aws_kms_key.almacenamiento.arn

  tags = local.etiquetas
}

resource "aws_efs_mount_target" "hpc_private" {
  count = length(var.subredes_privadas)

  file_system_id  = aws_efs_file_system.hpc.id
  subnet_id       = var.subredes_privadas[count.index]
  security_groups = [aws_security_group.efs.id]
}

resource "aws_efs_access_point" "hpc_ap" {
  file_system_id = aws_efs_file_system.hpc.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/hpc-data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "0755"
    }
  }

  tags = local.etiquetas
}

# RDS para datos estructurados - base de datos transaccional
resource "aws_db_instance" "principal" {
  identifier     = "${local.nombre_base}-${local.entorno}"
  engine         = var.motor_bd
  engine_version = var.version_motor_bd
  instance_class = var.clase_instancia_bd

  allocated_storage     = var.tamano_almacenamiento_bd
  max_allocated_storage = var.tamano_max_almacenamiento_bd

  storage_encrypted = true
  storage_type      = var.tipo_almacenamiento_bd

  db_name  = replace(local.nombre_base, "-", "_")
  username = var.usuario_admin_bd
  password = var.password_admin_bd

  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = var.nombre_subnet_group

  backup_retention_period = var.retension_backup
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  skip_final_snapshot       = var.entorno != "prod"
  final_snapshot_identifier = var.entorno == "prod" ? "${local.nombre_base}-final-${local.entorno}" : null

  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  performance_insights_enabled = var.entorno != "dev"
  performance_insights_kms_key = var.entorno != "dev" ? aws_kms_key.almacenamiento.arn : null

  tags = local.etiquetas
}

# DynamoDB para datos NoSQL de alta velocidad
resource "aws_dynamodb_table" "transacciones" {
  name           = "${local.nombre_base}-transacciones-${local.entorno}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "pk"
  range_key      = "sk"

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.almacenamiento.arn
  }

  attribute {
    name = "pk"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "N"
  }

  global_secondary_index {
    name            = "timestamp-index"
    hash_key        = "pk"
    range_key       = "timestamp"
    projection_type = "ALL"
  }

  ttl {
    attribute_name = "expiracion"
    enabled        = true
  }

  tags = local.etiquetas
}

resource "aws_dynamodb_table" "sesiones" {
  name           = "${local.nombre_base}-sesiones-${local.entorno}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "session_id"

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.almacenamiento.arn
  }

  attribute {
    name = "session_id"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  tags = local.etiquetas
}

# Clave KMS para cifrado de almacenamiento
resource "aws_kms_key" "almacenamiento" {
  description             = "Clave KMS para cifrado de almacenamiento del proyecto ${local.nombre_base}"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = merge(local.etiquetas, { Name = "${local.nombre_base}-kms-almacenamiento-${local.entorno}" })
}

resource "aws_kms_alias" "almacenamiento" {
  name          = "alias/${local.nombre_base}-almacenamiento-${local.entorno}"
  target_key_id = aws_kms_key.almacenamiento.key_id
}

# Security Groups
resource "aws_security_group" "efs" {
  name        = "${local.nombre_base}-efs-${local.entorno}"
  description = "Security group para EFS"
  vpc_id      = var.vpc_id

  tags = local.etiquetas
}

resource "aws_security_group_rule" "efs_ingress_nfs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.efs.id
}

resource "aws_security_group" "rds" {
  name        = "${local.nombre_base}-rds-${local.entorno}"
  description = "Security group para RDS"
  vpc_id      = var.vpc_id

  tags = local.etiquetas
}

resource "aws_security_group_rule" "rds_ingress_postgres" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_ingress_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.security_group_compute
  security_group_id        = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id
}

# Políticas de ciclo de vida S3
resource "aws_s3_bucket_lifecycle_configuration" "bigdata" {
  bucket = aws_s3_bucket.bigdata.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    transition {
      days          = 365
      storage_class = "DEEP_ARCHIVE"
    }
  }

  rule {
    id     = "expiration"
    status = "Enabled"

    expiration {
      days = 2555
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "landing" {
  bucket = aws_s3_bucket.landing.id

  rule {
    id     = "transition-to-intelligent-tiering"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "INTELLIGENT_TIERING"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }
}

// === ARCHIVO: modules/storage/outputs.tf ===
# Outputs del módulo de almacenamiento
# Expone ARNs, endpoints y referencias para otros módulos

output "bucket_bigdata_arn" {
  description = "ARN del bucket S3 para Big Data"
  value       = aws_s3_bucket.bigdata.arn
}

output "bucket_bigdata_name" {
  description = "Nombre del bucket S3 para Big Data"
  value       = aws_s3_bucket.bigdata.id
}

output "bucket_landing_arn" {
  description = "ARN del bucket S3 para datos landing"
  value       = aws_s3_bucket.landing.arn
}

output "bucket_landing_name" {
  description = "Nombre del bucket S3 para datos landing"
  value       = aws_s3_bucket.landing.id
}

output "bucket_procesados_arn" {
  description = "ARN del bucket S3 para datos procesados"
  value       = aws_s3_bucket.procesados.arn
}

output "bucket_procesados_name" {
  description = "Nombre del bucket S3 para datos procesados"
  value       = aws_s3_bucket.procesados.id
}

output "efs_id" {
  description = "ID del sistema de archivos EFS"
  value       = aws_efs_file_system.hpc.id
}

output "efs_dns_name" {
  description = "Nombre DNS del sistema de archivos EFS"
  value       = aws_efs_file_system.hpc.dns_name
}

output "efs_mount_target_ids" {
  description = "IDs de los mount targets de EFS"
  value       = aws_efs_mount_target.hpc_private[*].id
}

output "efs_security_group_id" {
  description = "ID del security group de EFS"
  value       = aws_security_group.efs.id
}

output "rds_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.principal.id
}

output "rds_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.principal.endpoint
}

output "rds_instance_address" {
  description = "Dirección de la instancia RDS"
  value       = aws_db_instance.principal.address
}

output "rds_instance_port" {
  description = "Puerto de la instancia RDS"
  value       = aws_db_instance.principal.port
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

output "dynamodb_transacciones_name" {
  description = "Nombre de la tabla DynamoDB de transacciones"
  value       = aws_dynamodb_table.transacciones.name
}

output "dynamodb_transacciones_arn" {
  description = "ARN de la tabla DynamoDB de transacciones"
  value       = aws_dynamodb_table.transacciones.arn
}

output "dynamodb_sesiones_name" {
  description = "Nombre de la tabla DynamoDB de sesiones"
  value       = aws_dynamodb_table.sesiones.name
}

output "dynamodb_sesiones_arn" {
  description = "ARN de la tabla DynamoDB de sesiones"
  value       = aws_dynamodb_table.sesiones.arn
}

output "kms_key_arn" {
  description = "ARN de la clave KMS de almacenamiento"
  value       = aws_kms_key.almacenamiento.arn
}

output "kms_key_id" {
  description = "ID de la clave KMS de almacenamiento"
  value       = aws_kms_key.almacenamiento.key_id
}

// === ARCHIVO: modules/security/main.tf ===
# Módulo de seguridad - SUPERFICIE DE PRÁCTICA
# Stub: el estudiante implementará las políticas IAM, roles y configuraciones de seguridad

locals {
  nombre_proyecto = var.nombre_proyecto
  entorno        = var.entorno
  etiquetas      = merge(var.etiquetas_comunes, { Entorno = local.entorno })
}

# Este módulo espera las siguientes variables que deben ser proporcionadas por el llamador:
# - nombre_proyecto: string
# - entorno: string
# - vpc_id: string
# - subredes_privadas: list(string)
# - bucket_bigdata_arn: string
# - bucket_landing_arn: string
# - bucket_procesados_arn: string
# - efs_id: string
# - rds_instance_endpoint: string
# - dynamodb_tablas: map(string)
# - cluster_eks_name: string
# - etiquetas_comunes: map(string)

# El estudiante deberá implementar:
# - Políticas IAM para roles de compute (EC2, ECS, EKS)
# - Políticas IAM para roles de Big Data (EMR, Glue, Kinesis)
# - Security Groups para las diferentes capas
# - Configuración de KMS para claves adicionales
# - Políticas de acceso a buckets S3
# - Roles IAM con principio de menor privilegio

resource "aws_iam_role" "placeholder" {
  name = "placeholder-role-${local.entorno}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  tags = local.etiquetas
}

# Stub: aquí el estudiante implementará las políticas IAM reales
# según los requisitos de seguridad del reto


// === ARCHIVO: modules/security/outputs.tf ===
# Outputs del módulo de seguridad
# Superficie de práctica: el estudiante debe implementar los outputs requeridos
# según los requisitos de seguridad del proyecto

output "security_group_ids" {
  description = "IDs de los security groups creados"
  # value       = # TODO: retornar los IDs de los security groups
}

output "iam_role_arns" {
  description = "ARNs de los roles IAM creados"
  # value       = # TODO: retornar los ARNs de los roles IAM
}

output "kms_key_arn" {
  description = "ARN de la clave KMS"
  # value       = # TODO: retornar el ARN de la clave KMS
}

output "policy_arns" {
  description = "ARNs de las políticas IAM"
  # value       = # TODO: retornar los ARNs de las políticas
}

// === ARCHIVO: modules/monitoring/main.tf ===
# Módulo de monitoreo y observabilidad
# Configura CloudWatch, CloudTrail y dashboards para el ecosistema

# --------------------------------------------------------------------------
# Configuración de CloudWatch Logs
# --------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "main" {
  for_each = var.log_groups

  name              = each.value.name
  retention_in_days = each.value.retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}

# --------------------------------------------------------------------------
# Métricas personalizadas para la aplicación
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "cpu-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.cpu_threshold
  alarm_description   = "Alerta de utilización de CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "memory_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "memory-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.memory_threshold
  alarm_description   = "Alerta de utilización de memoria"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_utilization" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "disk-utilization-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "DiskSpaceUtilization"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = var.disk_threshold
  alarm_description   = "Alerta de utilización de disco"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}",
    path       = "/"
  }
}

resource "aws_cloudwatch_metric_alarm" "network_in" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "network-in-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.network_threshold
  alarm_description   = "Alerta de tráfico de entrada"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

resource "aws_cloudwatch_metric_alarm" "network_out" {
  count               = var.enable_alarms ? var.instance_counts : 0
  alarm_name          = "network-out-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "NetworkOut"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = var.network_threshold
  alarm_description   = "Alerta de tráfico de salida"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    InstanceId = "i-${count.index}"
  }
}

# --------------------------------------------------------------------------
# Alarmas de aplicación (latencia, errores, throughput)
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "latency_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-latency-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Latency"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Average"
  threshold           = var.latency_threshold
  alarm_description   = "Alerta de latencia alta"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "error_rate_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-error-rate-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Sum"
  threshold           = var.error_threshold
  alarm_description   = "Alerta de tasa de errores"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

resource "aws_cloudwatch_metric_alarm" "request_count_high" {
  count               = var.enable_alarms ? 1 : 0
  alarm_name          = "application-request-count-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Requests"
  namespace           = var.application_namespace
  period              = "60"
  statistic           = "Sum"
  threshold           = var.request_count_threshold
  alarm_description   = "Alerta de volumen de solicitudes"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags
}

# --------------------------------------------------------------------------
# Alarmas de auto-scaling
# --------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  for_each = var.enable_alarms ? var.asg_names : []

  alarm_name          = "asg-cpu-high-${each.value}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Average"
  threshold           = var.asg_cpu_threshold
  alarm_description   = "Escalar hacia arriba por CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    AutoScalingGroupName = each.value
  }
}

resource "aws_cloudwatch_metric_alarm" "asg_cpu_low" {
  for_each = var.enable_alarms ? var.asg_names : []

  alarm_name          = "asg-cpu-low-${each.value}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "300"
  statistic           = "Average"
  threshold           = var.asg_cpu_low_threshold
  alarm_description   = "Escalar hacia abajo por CPU"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]
  tags                = var.common_tags

  dimensions = {
    AutoScalingGroupName = each.value
  }
}

# --------------------------------------------------------------------------
# CloudTrail para auditoría
# --------------------------------------------------------------------------
resource "aws_cloudtrail" "main" {
  count = var.enable_cloudtrail ? 1 : 0

  name                          = var.cloudtrail_name
  s3_bucket_name                = var.cloudtrail_bucket
  include_global_service_events = true
  is_multi_region_trail         = var.cloudtrail_multi_region
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_account
  kms_key_id                    = var.kms_key_arn

  event_selector {
    read_write_type           = "All"
    include_management_events = true
    data_resource {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::"]
    }
  }

  tags = var.common_tags
}

resource "aws_cloudwatch_log_stream" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  name           = var.cloudtrail_log_stream_name
  log_group_name = aws_cloudwatch_log_group.cloudtrail[0].name
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  count = var.enable_cloudtrail ? 1 : 0

  name              = "/aws/cloudtrail/${var.cloudtrail_name}"
  retention_in_days = var.cloudtrail_retention_days
  kms_key_id        = var.kms_key_arn
  tags              = var.common_tags
}

resource "aws_cloudtrail" "cloudtrail_cloudwatch" {
  count = var.enable_cloudtrail ? 1 : 0

  name                          = var.cloudtrail_name
  s3_bucket_name                = var.cloudtrail_bucket
  cloud_watch_logs_group_arn    = aws_cloudwatch_log_group.cloudtrail[0].arn
  cloud_watch_logs_role_arn     = var.cloudtrail_cloudwatch_role_arn
  include_global_service_events = true
  is_multi_region_trail         = var.cloudtrail_multi_region
  enable_log_file_validation    = true
  is_organization_trail         = var.is_organization_account
  kms_key_id                    = var.kms_key_arn

  tags = var.common_tags
}

# --------------------------------------------------------------------------
# Dashboard de CloudWatch
# --------------------------------------------------------------------------
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    "widgets" = [
      {
        "type" = "metric"
        "properties" = {
          "title" = "CPU Utilization"
          "metrics" = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-2", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
          "annotations" = {
            "horizontal" = [
              {"value" = var.cpu_threshold, "label" = "Umbral CPU"}
            ]
          }
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Memory Utilization"
          "metrics" = [
            ["CWAgent", "MemoryUtilization", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-2", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Network Traffic"
          "metrics" = [
            ["AWS/EC2", "NetworkIn", "InstanceId", "i-0", {"stat" = "Average"}],
            [".", "NetworkOut", ".", "i-0", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}],
            [".", ".", ".", "i-1", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Application Latency"
          "metrics" = [
            [var.application_namespace, "Latency", {"stat" = "Average"}],
            [var.application_namespace, "Latency", {"stat" = "Maximum"}]
          ]
          "period" = 60
          "stat"   = "Average"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Application Errors"
          "metrics" = [
            [var.application_namespace, "Errors", {"stat" = "Sum"}],
            [var.application_namespace, "Requests", {"stat" = "Sum"}]
          ]
          "period" = 60
          "stat"   = "Sum"
          "region" = var.aws_region
        }
      },
      {
        "type" = "metric"
        "properties" = {
          "title" = "Disk Usage"
          "metrics" = [
            ["CWAgent", "DiskSpaceUtilization", "InstanceId", "i-0", "path", "/", {"stat" = "Average"}],
            [".", ".", ".", "i-1", ".", ".", {"stat" = "Average"}],
            [".", ".", ".", "i-2", ".", ".", {"stat" = "Average"}]
          ]
          "period" = 300
          "stat"   = "Average"
          "region" = var.aws_region
        }
      }
    ]
  })
}

// === ARCHIVO: modules/monitoring/outputs.tf ===
# Outputs del módulo de monitoreo
# Expone los recursos creados para consumo por otros módulos

output "log_group_arns" {
  description = "ARNs de los grupos de CloudWatch Logs"
  value       = { for k, v in aws_cloudwatch_log_group.main : k => v.arn }
}

output "log_group_names" {
  description = "Nombres de los grupos de CloudWatch Logs"
  value       = { for k, v in aws_cloudwatch_log_group.main : k => v.name }
}

output "cpu_alarm_arns" {
  description = "ARNs de las alarmas de CPU"
  value       = aws_cloudwatch_metric_alarm.cpu_utilization[*].arn
}

output "memory_alarm_arns" {
  description = "ARNs de las alarmas de memoria"
  value       = aws_cloudwatch_metric_alarm.memory_utilization[*].arn
}

output "disk_alarm_arns" {
  description = "ARNs de las alarmas de disco"
  value       = aws_cloudwatch_metric_alarm.disk_utilization[*].arn
}

output "network_alarm_arns" {
  description = "ARNs de las alarmas de red"
  value       = concat(
    aws_cloudwatch_metric_alarm.network_in[*].arn,
    aws_cloudwatch_metric_alarm.network_out[*].arn
  )
}

output "application_alarm_arns" {
  description = "ARNs de las alarmas de aplicación"
  value       = concat(
    aws_cloudwatch_metric_alarm.latency_high[*].arn,
    aws_cloudwatch_metric_alarm.error_rate_high[*].arn,
    aws_cloudwatch_metric_alarm.request_count_high[*].arn
  )
}

output "asg_alarm_arns" {
  description = "ARNs de las alarmas de auto-scaling"
  value       = concat(
    aws_cloudwatch_metric_alarm.asg_cpu_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_low[*].arn
  )
}

output "all_alarm_arns" {
  description = "Todos los ARNs de alarmas creadas"
  value       = concat(
    aws_cloudwatch_metric_alarm.cpu_utilization[*].arn,
    aws_cloudwatch_metric_alarm.memory_utilization[*].arn,
    aws_cloudwatch_metric_alarm.disk_utilization[*].arn,
    aws_cloudwatch_metric_alarm.network_in[*].arn,
    aws_cloudwatch_metric_alarm.network_out[*].arn,
    aws_cloudwatch_metric_alarm.latency_high[*].arn,
    aws_cloudwatch_metric_alarm.error_rate_high[*].arn,
    aws_cloudwatch_metric_alarm.request_count_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_high[*].arn,
    aws_cloudwatch_metric_alarm.asg_cpu_low[*].arn
  )
}

output "dashboard_name" {
  description = "Nombre del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_name
}

output "dashboard_id" {
  description = "ID del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_id
}

output "dashboard_arn" {
  description = "ARN del dashboard de CloudWatch"
  value       = aws_cloudwatch_dashboard.main.dashboard_arn
}

output "cloudtrail_arn" {
  description = "ARN del trail de CloudTrail"
  value       = try(aws_cloudtrail.main[0].arn, null)
}

output "cloudtrail_id" {
  description = "ID del trail de CloudTrail"
  value       = try(aws_cloudtrail.main[0].id, null)
}

output "cloudtrail_log_group_arn" {
  description = "ARN del grupo de logs de CloudTrail"
  value       = try(aws_cloudwatch_log_group.cloudtrail[0].arn, null)
}

output "all_cloudwatch_resources" {
  description = "Mapa con todos los recursos de CloudWatch creados"
  value       = {
    log_groups    = { for k, v in aws_cloudwatch_log_group.main : k => { arn = v.arn, name = v.name } }
    alarms_count  = length(concat(aws_cloudwatch_metric_alarm.cpu_utilization[*].arn, aws_cloudwatch_metric_alarm.memory_utilization[*].arn))
    dashboard     = { name = aws_cloudwatch_dashboard.main.dashboard_name, id = aws_cloudwatch_dashboard.main.dashboard_id }
    cloudtrail    = try({ arn = aws_cloudtrail.main[0].arn, id = aws_cloudtrail.main[0].id }, null)
  }
}


// === ARCHIVO: modules/bigdata/main.tf ===
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# =============================================================================
# MÓDULO DE BIG DATA - Servicios de procesamiento y análisis de gran escala
# =============================================================================
# Este módulo provisiona la infraestructura necesaria para soluciones de Big Data
# incluyendo streaming, almacenamiento de eventos, procesamiento distribuido y
# data warehousing. Cada servicio sigue principios de alta disponibilidad y
# escalabilidad horizontal para cumplir con los requisitos de 50K req/s.

# -----------------------------------------------------------------------------# KINESIS DATA STREAM - Ingesta de streaming en tiempo real
# -----------------------------------------------------------------------------resource "aws_kinesis_stream" "main" {
  name             = "${var.project_name}-${var.environment}-kinesis-stream"
  shard_count      = var.kinesis_shard_count
  retention_period = var.kinesis_retention_hours
  shard_level_metrics = ["IncomingBytes", "OutgoingBytes"]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-${var.environment}-kinesis-stream"
      ServiceType = "KinesisDataStreams"
      Environment = var.environment
    }
  )
}

# Kinesis Server-Side Encryption
resource "aws_kinesis_stream_consumer" "analytics_consumer" {
  for_each = toset(var.kinesis_consumers)

  stream_arn = aws_kinesis_stream.main.arn
  name       = "${var.project_name}-${var.environment}-${each.key}-consumer"

  tags = merge(var.common_tags, {
    ConsumerName = each.key
  })
}

# -----------------------------------------------------------------------------# MSK (Managed Streaming for Apache Kafka) - Broker de mensajes
# -----------------------------------------------------------------------------resource "aws_msk_cluster" "main" {
  cluster_name           = "${var.project_name}-${var.environment}-msk"
  kafka_version          = var.msk_kafka_version
  number_of_broker_nodes = var.msk_broker_nodes

  broker_node_group_info {
    instance_type   = var.msk_instance_type
    client_subnets  = var.private_subnet_ids
    security_groups = [aws_security_group.msk.id]
    storage_info {
      ebs_storage_info {
        volume_size = var.msk_storage_size
      }
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.kms_key_arn
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk.id
      }
      s3 {
        enabled = true
        bucket  = aws_s3_bucket.msk_logs.id
      }
    }
  }

  open_monitoring {
    prometheus {
      enabled = true
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-msk"
    ServiceType = "MSK"
  })
}

resource "aws_cloudwatch_log_group" "msk" {
  name              = "/aws/msk/${var.project_name}-${var.environment}"
  retention_in_days = var.log_retention_days

  tags = var.common_tags
}

resource "aws_s3_bucket" "msk_logs" {
  bucket = "${var.project_name}-${var.environment}-msk-logs"

  tags = merge(var.common_tags, {
    Name = "MSK Logs Bucket"
  })
}

resource "aws_s3_bucket_server_side_encryption_configuration" "msk_logs" {
  bucket = aws_s3_bucket.msk_logs.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_arn
      sse_algorithm     = "aws:kms"
    }
  }
}

# -----------------------------------------------------------------------------# EMR - Procesamiento distribuido con Spark/Hadoop
# -----------------------------------------------------------------------------resource "aws_emr_cluster" "main" {
  name                  = "${var.project_name}-${var.environment}-emr-cluster"
  release_label         = var.emr_release_label
  applications          = var.emr_applications
  service_role          = aws_iam_role.emr_service_role.arn
  security_configuration = aws_emr_security_configuration.emr_sec_config.id

  core_instance_group {
    instance_type  = var.emr_core_instance_type
    instance_count = var.emr_core_instance_count
    ebs_config {
      size                 = var.emr_core_ebs_size
      type                 = "gp3"
      volumes_per_instance = 1
    }
  }

  master_instance_group {
    instance_type = var.emr_master_instance_type
    instance_count = 1
    ebs_config {
      size                 = var.emr_master_ebs_size
      type                 = "gp3"
      volumes_per_instance = 1
    }
  }

  ec2_attributes {
    emr_managed_master_security_group = aws_security_group.emr_master.id
    emr_managed_slave_security_group  = aws_security_group.emr_slave.id
    instance_profile                  = aws_iam_instance_profile.emr_ec2.arn
    subnet_id                         = var.private_subnet_ids[0]
  }

  step_concurrency_level = var.emr_step_concurrency

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-emr"
    ServiceType = "EMR"
  })
}

resource "aws_emr_security_configuration" "emr_sec_config" {
  name = "${var.project_name}-${var.environment}-emr-sec-config"

  configuration = jsonencode({
    "EncryptionConfiguration" : {
      "EnableAtRestEncryption" : true,
      "EnableInTransitEncryption" : true,
      "AtRestEncryptionConfiguration" : {
        "S3EncryptionConfiguration" : {
          "EncryptionMode" : "SSE-KMS",
          "KmsKeyArn"       = var.kms_key_arn
        }
      },
      "InTransitEncryptionConfiguration" : {
        "TLSCertificateConfiguration" : {
          "CertificateArn" : var.acm_certificate_arn
        }
      }
    }
  })
}

# -----------------------------------------------------------------------------# AWS Glue - ETL serverless y Data Catalog
# -----------------------------------------------------------------------------resource "aws_glue_catalog_database" "data_lake" {
  name        = "${var.project_name}_${var.environment}_data_lake"
  description = "Data Lake metadata catalog for ${var.project_name}"

  parameters = {
    "CreatedBy" : "Terraform"
    "Environment" : var.environment
  }

  tags = var.common_tags
}

resource "aws_glue_crawler" "raw_data_crawler" {
  for_each = toset(var.glue_crawlers)

  name          = "${var.project_name}-${var.environment}-${each.key}-crawler"
  database_name = aws_glue_catalog_database.data_lake.name
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${var.raw_data_bucket}/${each.key}/"
  }

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "LOG"
  }

  configuration = jsonencode({
    "Version" : 1,
    "CrawlerOutput" : {
      "Partitions" : {
        "AddOrUpdateBehavior" : "INHERIT_FROM_TABLE"
      }
    }
  })

  tags = merge(var.common_tags, {
    CrawlerName = each.key
  })
}

resource "aws_glue_job" "etl_job" {
  for_each = toset(var.glue_jobs)

  name     = "${var.project_name}-${var.environment}-${each.key}-job"
  role_arn = aws_iam_role.glue_job_role.arn
  glue_version = var.glue_glue_version
  worker_type  = var.glue_worker_type
  number_of_workers = var.glue_number_of_workers

  command {
    script_location = "s3://${var.glue_scripts_bucket}/${each.key}/etl_script.py"
    python_version  = "3"
  }

  default_arguments = {
    "--job-language"           = "python"
    "--enable-metrics"         = ""
    "--enable-continuous-cloudwatch-log" = "true"
    "--enable-spark-ui"        = "true"
    "--spark-event-log-path"   = "s3://${var.spark_ui_bucket}/spark-history/"
    "--extra-py-files"         = "s3://${var.glue_scripts_bucket}/common/utils.zip"
    "--TempDir"                = "s3://${var.temp_bucket}/"
  }

  execution_property {
    max_concurrent_runs = var.glue_max_concurrent_runs
  }

  tags = merge(var.common_tags, {
    JobName = each.key
  })
}

# -----------------------------------------------------------------------------# Amazon Redshift - Data Warehouse analítico
# -----------------------------------------------------------------------------resource "aws_redshift_cluster" "main" {
  cluster_identifier        = "${var.project_name}-${var.environment}-redshift"
  cluster_type              = var.redshift_cluster_type
  node_type                 = var.redshift_node_type
  number_of_nodes           = var.redshift_number_of_nodes
  master_username           = var.redshift_master_username
  master_password           = var.redshift_master_password
  database_name             = var.redshift_database_name
  port                      = var.redshift_port
  cluster_subnet_group_name = aws_redshift_subnet_group.main.name
  vpc_security_group_ids   = [aws_security_group.redshift.id]

  iam_roles = [aws_iam_role.redshift_s3_access.arn]

  logging {
    enable        = true
    bucket_name   = aws_s3_bucket.redshift_logs.id
    log_interval  = 300
  }

  encrypted             = true
  kms_key_id            = var.kms_key_arn
  skip_final_snapshot   = var.environment != "prod"
  final_cluster_snapshot_name = var.environment == "prod" ? "${var.project_name}-final-snapshot" : null

  parameter_group_name = aws_redshift_parameter_group.main.name

  lifecycle {
    ignore_changes = ["master_password"]
  }

  tags = merge(var.common_tags, {
    Name        = "${var.project_name}-${var.environment}-redshift"
    ServiceType = "Redshift"
  })
}

resource "aws_redshift_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-redshift-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = var.common_tags
}

resource "aws_redshift_parameter_group" "main" {
  name   = "${var.project_name}-${var.environment}-redshift-params"
  family = var.redshift_parameter_family

  parameter {
    name  = "enable_user_activity_logging"
    value = "true"
  }

  parameter {
    name  = "statement_timeout"
    value = var.redshift_statement_timeout
  }
}

# -----------------------------------------------------------------------------# Security Groups para servicios de Big Data
# -----------------------------------------------------------------------------resource "aws_security_group" "msk" {
  name        = "${var.project_name}-${var.environment}-msk-sg"
  description = "Security group for MSK cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "MSK PLAINTEXT"
  }

  ingress {
    from_port   = 9094
    to_port     = 9094
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "MSK TLS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "MSK Security Group"
  })
}

resource "aws_security_group" "emr_master" {
  name        = "${var.project_name}-${var.environment}-emr-master-sg"
  description = "EMR Master node security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    self        = true
    description = "EMR Web UI"
  }

  ingress {
    from_port   = 9443
    to_port     = 9443
    protocol    = "tcp"
    self        = true
    description = "EMR History Server"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "EMR Master Security Group"
  })
}

resource "aws_security_group" "emr_slave" {
  name        = "${var.project_name}-${var.environment}-emr-slave-sg"
  description = "EMR Core/Task nodes security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
    description = "EMR Internal Communication"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "EMR Slave Security Group"
  })
}

resource "aws_security_group" "redshift" {
  name        = "${var.project_name}-${var.environment}-redshift-sg"
  description = "Redshift cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
    description = "Redshift"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "Redshift Security Group"
  })
}

// === ARCHIVO: modules/bigdata/outputs.tf ===
# =============================================================================
# OUTPUTS DEL MÓDULO DE BIG DATA
# =============================================================================
# Exporta los ARNs, endpoints y configuraciones de los servicios provisionados
# para consumo por otros módulos y para referencia externa.

# Kinesis Outputs
output "kinesis_stream_arn" {
  description = "ARN del Kinesis Data Stream"
  value       = aws_kinesis_stream.main.arn
}

output "kinesis_stream_name" {
  description = "Nombre del Kinesis Data Stream"
  value       = aws_kinesis_stream.main.name
}

output "kinesis_stream_shard_count" {
  description = "Número de shards del stream"
  value       = aws_kinesis_stream.main.shard_count
}

output "kinesis_consumers" {
  description = "Mapa de consumidores de Kinesis"
  value       = aws_kinesis_stream_consumer.analytics_consumer
}

# MSK Outputs
output "msk_cluster_arn" {
  description = "ARN del cluster MSK"
  value       = aws_msk_cluster.main.arn
}

output "msk_cluster_name" {
  description = "Nombre del cluster MSK"
  value       = aws_msk_cluster.main.cluster_name
}

output "msk_bootstrap_brokers_tls" {
  description = "Brokers MSK con TLS"
  value       = aws_msk_cluster.main.bootstrap_brokers_tls
  sensitive   = true
}

output "msk_bootstrap_brokers_sasl_scram" {
  description = "Brokers MSK con SASL SCRAM"
  value       = try(aws_msk_cluster.main.bootstrap_brokers_sasl_scram, null)
  sensitive   = true
}

output "msk_zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = aws_msk_cluster.main.zookeeper_connect_string
  sensitive   = true
}

output "msk_security_group_id" {
  description = "ID del security group de MSK"
  value       = aws_security_group.msk.id
}

# EMR Outputs
output "emr_cluster_id" {
  description = "ID del cluster EMR"
  value       = aws_emr_cluster.main.id
}

output "emr_cluster_name" {
  description = "Nombre del cluster EMR"
  value       = aws_emr_cluster.main.name
}

output "emr_master_public_dns" {
  description = "DNS público del nodo master EMR"
  value       = aws_emr_cluster.main.master_public_dns
}

output "emr_master_security_group_id" {
  description = "ID del security group del master EMR"
  value       = aws_security_group.emr_master.id
}

output "emr_slave_security_group_id" {
  description = "ID del security group de los nodos slave EMR"
  value       = aws_security_group.emr_slave.id
}

# Glue Outputs
output "glue_catalog_database_name" {
  description = "Nombre de la base de datos Glue Catalog"
  value       = aws_glue_catalog_database.data_lake.name
}

output "glue_crawlers" {
  description = "Mapa de crawlers Glue"
  value       = aws_glue_crawler.raw_data_crawler
}

output "glue_jobs" {
  description = "Mapa de jobs Glue ETL"
  value       = aws_glue_job.etl_job
}

# Redshift Outputs
output "redshift_cluster_endpoint" {
  description = "Endpoint de conexión al cluster Redshift"
  value       = aws_redshift_cluster.main.endpoint
}

output "redshift_cluster_arn" {
  description = "ARN del cluster Redshift"
  value       = aws_redshift_cluster.main.arn
}

output "redshift_cluster_id" {
  description = "ID del cluster Redshift"
  value       = aws_redshift_cluster.main.id
}

output "redshift_security_group_id" {
  description = "ID del security group de Redshift"
  value       = aws_security_group.redshift.id
}

output "redshift_jdbc_url" {
  description = "URL JDBC de conexión a Redshift"
  value       = "jdbc:redshift://${aws_redshift_cluster.main.endpoint}:${var.redshift_port}/${var.redshift_database_name}"
}

# URLs de servicios para consumo externo
output "service_endpoints" {
  description = "Mapa de endpoints de todos los servicios de Big Data"
  value = {
    kinesis = {
      stream_arn = aws_kinesis_stream.main.arn
      stream_name = aws_kinesis_stream.main.name
    }
    msk = {
      bootstrap_brokers = aws_msk_cluster.main.bootstrap_brokers_tls
      zookeeper = aws_msk_cluster.main.zookeeper_connect_string
    }
    emr = {
      master_dns = aws_emr_cluster.main.master_public_dns
      cluster_id = aws_emr_cluster.main.id
    }
    glue = {
      catalog_database = aws_glue_catalog_database.data_lake.name
    }
    redshift = {
      endpoint = aws_redshift_cluster.main.endpoint
      port     = var.redshift_port
      database = var.redshift_database_name
    }
  }
}

// === ARCHIVO: modules/security/iam_policies.tf ===
# =============================================================================
# DEFINICIÓN DE POLÍTICAS IAM - SUPERFICIE DE PRÁCTICA
# =============================================================================
# Este archivo contiene las definiciones de políticas IAM que el candidato
# debe completar aplicando el principio de menor privilegio.

# Política para acceso a S3 - COMPLETAR por el estudiante
data "aws_iam_policy_document" "s3_access" {
  statement {
    sid = "AllowListBuckets"
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:ListBucket"
    ]

    resources = ["arn:aws:s3:::*"]
  }

  statement {
    sid = "AllowReadWriteSpecificBuckets"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    # TODO: Especificar los ARNs de los buckets específicos del proyecto
    resources = []
  }
}

# Política para acceso a Kinesis - COMPLETAR por el estudiante
data "aws_iam_policy_document" "kinesis_access" {
  statement {
    sid = "AllowKinesisReadWrite"
    effect = "Allow"

    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:ListShards",
      "kinesis:PutRecord",
      "kinesis:PutRecords"
    ]

    # TODO: Especificar el ARN del stream específico
    resources = []
  }
}

# Política para acceso a MSK - COMPLETAR por el estudiante
data "aws_iam_policy_document" "msk_access" {
  statement {
    sid = "AllowMSKConnect"
    effect = "Allow"

    actions = [
      "kafka:DescribeCluster",
      "kafka:GetBootstrapBrokers"
    ]

    # TODO: Especificar el ARN del cluster MSK específico
    resources = []
  }
}

# Política para acceso a Redshift - COMPLETAR por el estudiante
data "aws_iam_policy_document" "redshift_access" {
  statement {
    sid = "AllowRedshiftAccess"
    effect = "Allow"

    actions = [
      "redshift:DescribeClusters",
      "redshift:DescribeLoggingStatus"
    ]

    # TODO: Especificar el ARN del cluster Redshift específico
    resources = []
  }
}

# Política para acceso a Glue - COMPLETAR por el estudiante
data "aws_iam_policy_document" "glue_access" {
  statement {
    sid = "AllowGlueOperations"
    effect = "Allow"

    actions = [
      "glue:GetDatabase",
      "glue:GetTables",
      "glue:GetTable",
      "glue:StartCrawler",
      "glue:GetCrawler"
    ]

    resources = ["*"]
  }
}

# Política para CloudWatch Logs - COMPLETAR por el estudiante
data "aws_iam_policy_document" "cloudwatch_logs_access" {
  statement {
    sid = "AllowLogsWrite"
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    # TODO: Especificar los ARNs de los log groups específicos
    resources = []
  }
}

# Política para KMS - COMPLETAR por el estudiante
data "aws_iam_policy_document" "kms_access" {
  statement {
    sid = "AllowKMSDecrypt"
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey"
    ]

    # TODO: Especificar el ARN de la clave KMS específica
    resources = []
  }
}

# Política para EMR - COMPLETAR por el estudiante
data "aws_iam_policy_document" "emr_access" {
  statement {
    sid = "AllowEMROperations"
    effect = "Allow"

    actions = [
      "elasticmapreduce:*Cluster",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:ListInstances"
    ]

    # TODO: Especificar el ARN del cluster EMR específico
    resources = []
  }
}


// === ARCHIVO: modules/bigdata/kinesis.tf ===
resource "aws_kinesis_stream" "main" {
  name             = var.kinesis_stream_name
  shard_count      = var.kinesis_shard_count
  retention_period = var.kinesis_retention_hours
  encryption_type  = "KMS"
  kms_key_id       = var.kinesis_kms_key_arn
  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

  tags = merge(
    var.common_tags,
    {
      Name        = var.kinesis_stream_name
      Description = "Kinesis Data Stream for high-volume transaction processing"
      Component   = "BigData"
      Environment = var.environment
    }
  )
}

resource "aws_kinesis_stream_consumer" "consumer_registration" {
  for_each       = toset(var.kinesis_consumer_arns)
  stream_arn     = aws_kinesis_stream.main.arn
  consumer_name  = each.value
}

resource "aws_cloudwatch_log_group" "kinesis_logs" {
  name              = "/aws/kinesis/${var.kinesis_stream_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-logs"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "iterator_age_alarm" {
  alarm_name          = "${var.kinesis_stream_name}-iterator-age-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "GetRecords.IteratorAgeMilliseconds"
  namespace           = "AWS/Kinesis"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.kinesis_iterator_age_threshold
  alarm_description   = "This alarm triggers when Kinesis iterator age exceeds threshold"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    StreamName = aws_kinesis_stream.main.name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-iterator-age"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "write_throughput_alarm" {
  alarm_name          = "${var.kinesis_stream_name}-write-throttle"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "WriteProvisionedThroughputExceeded"
  namespace           = "AWS/Kinesis"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This alarm triggers when Kinesis write is throttled"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    StreamName = aws_kinesis_stream.main.name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-write-throttle"
    Environment = var.environment
  })
}

resource "aws_s3_bucket" "kinesis_backup" {
  count  = var.enable_kinesis_backup ? 1 : 0
  bucket = "${var.kinesis_stream_name}-backup-${var.environment}"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kinesis_kms_key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    enabled = true
    transition {
      days          = 30
      storage_class = "GLACIER"
    }
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-backup"
    Environment = var.environment
  })
}

// === ARCHIVO: modules/bigdata/kinesis_producer.tf ===
data "aws_iam_policy_document" "kinesis_producer_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "kinesis_producer_role" {
  name               = "${var.kinesis_stream_name}-producer-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_producer_assume.json

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-role"
    Environment = var.environment
  })
}

data "aws_iam_policy_document" "kinesis_producer_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kinesis:PutRecord",
      "kinesis:PutRecords",
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator"
    ]
    resources = [aws_kinesis_stream.main.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:${data.aws_partition.current.partition}:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.kinesis_producer_function_name}*"]
  }

  statement {
    effect = "Allow"
    actions = ["kms:Encrypt", "kms:Decrypt"]
    resources = [var.kinesis_kms_key_arn]
  }
}

resource "aws_iam_policy" "kinesis_producer_policy" {
  name        = "${var.kinesis_stream_name}-producer-policy"
  policy      = data.aws_iam_policy_document.kinesis_producer_policy.json
  description = "IAM policy for Kinesis producer Lambda with least privilege"

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-policy"
    Environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_producer_attach" {
  role       = aws_iam_role.kinesis_producer_role.name
  policy_arn = aws_iam_policy.kinesis_producer_policy.arn
}

resource "aws_lambda_function" "kinesis_producer" {
  filename         = var.kinesis_producer_zip_path
  function_name    = var.kinesis_producer_function_name
  role            = aws_iam_role.kinesis_producer_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.kinesis_producer_zip_path)
  runtime          = "python3.11"
  timeout          = var.kinesis_producer_timeout
  memory_size      = var.kinesis_producer_memory_size
  environment {
    variables = {
      STREAM_NAME           = aws_kinesis_stream.main.name
      REGION                = var.region
      BATCH_SIZE            = var.kinesis_producer_batch_size
      MAX_RETRIES           = var.kinesis_producer_max_retries
      LOG_LEVEL             = var.log_level
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name        = var.kinesis_producer_function_name
    Environment = var.environment
  })
}

resource "aws_cloudwatch_log_group" "kinesis_producer_logs" {
  name              = "/aws/lambda/${var.kinesis_producer_function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_producer_function_name}-logs"
    Environment = var.environment
  })
}

resource "aws_lambda_event_source_mapping" "kinesis_producer_source" {
  event_source_arn                   = aws_kinesis_stream.main.arn
  function_name                      = aws_lambda_function.kinesis_producer.arn
  batch_size                         = var.kinesis_producer_batch_size
  starting_position                  = "LATEST"
  destination_config {
    on_failure {
      destination_arn = var.kinesis_dlq_arn
    }
  }
  maximum_record_age_in_seconds     = var.kinesis_max_record_age
  maximum_batching_window_in_seconds = var.kinesis_batching_window
  bisect_batch_on_function_error     = var.kinesis_bisect_on_error
  retry_strategy {
    maximumimum_retry_attempts = var.kinesis_producer_max_retries
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-producer-mapping"
    Environment = var.environment
  })
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

// === ARCHIVO: modules/bigdata/kinesis_consumer.tf ===
data "aws_iam_policy_document" "kinesis_consumer_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "kinesis_consumer_role" {
  name               = "${var.kinesis_stream_name}-consumer-role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_consumer_assume.json

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-role"
    Environment = var.environment
  })
}

data "aws_iam_policy_document" "kinesis_consumer_policy" {
  statement {
    effect = "Allow"
    actions = [
      "kinesis:GetRecords",
      "kinesis:GetShardIterator",
      "kinesis:DescribeStream",
      "kinesis:ListShards"
    ]
    resources = [aws_kinesis_stream.main.arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:${data.aws_partition.current.partition}:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.kinesis_consumer_function_name}*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [var.dynamodb_table_arn]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes"
    ]
    resources = [var.kinesis_dlq_arn]
  }

  statement {
    effect = "Allow"
    actions = ["kms:Encrypt", "kms:Decrypt", "kms:GenerateDataKey"]
    resources = [var.kinesis_kms_key_arn]
  }
}

resource "aws_iam_policy" "kinesis_consumer_policy" {
  name        = "${var.kinesis_stream_name}-consumer-policy"
  policy      = data.aws_iam_policy_document.kinesis_consumer_policy.json
  description = "IAM policy for Kinesis consumer Lambda with least privilege"

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-policy"
    Environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "kinesis_consumer_attach" {
  role       = aws_iam_role.kinesis_consumer_role.name
  policy_arn = aws_iam_policy.kinesis_consumer_policy.arn
}

resource "aws_lambda_function" "kinesis_consumer" {
  filename         = var.kinesis_consumer_zip_path
  function_name    = var.kinesis_consumer_function_name
  role            = aws_iam_role.kinesis_consumer_role.arn
  handler          = "index.handler"
  source_code_hash = filebase64sha256(var.kinesis_consumer_zip_path)
  runtime          = "python3.11"
  timeout          = var.kinesis_consumer_timeout
  memory_size      = var.kinesis_consumer_memory_size
  environment {
    variables = {
      STREAM_NAME              = aws_kinesis_stream.main.name
      REGION                   = var.region
      DYNAMODB_TABLE_NAME      = var.dynamodb_table_name
      DLQ_URL                  = var.kinesis_dlq_url
      BATCH_SIZE               = var.kinesis_consumer_batch_size
      MAX_CONCURRENT_BATCHES   = var.kinesis_max_concurrent_batches
      LOG_LEVEL                = var.log_level
      ENABLE_DLQ               = var.enable_dlq_for_failed_messages
      PROCESSING_ERROR_SNS_ARN = var.sns_topic_arn
    }
  }

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name        = var.kinesis_consumer_function_name
    Environment = var.environment
  })
}

resource "aws_cloudwatch_log_group" "kinesis_consumer_logs" {
  name              = "/aws/lambda/${var.kinesis_consumer_function_name}"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.kinesis_kms_key_arn

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-logs"
    Environment = var.environment
  })
}

resource "aws_lambda_event_source_mapping" "kinesis_consumer_source" {
  event_source_arn                   = aws_kinesis_stream.main.arn
  function_name                      = aws_lambda_function.kinesis_consumer.arn
  batch_size                         = var.kinesis_consumer_batch_size
  starting_position                  = "LATEST"
  destination_config {
    on_failure {
      destination_arn = var.kinesis_dlq_arn
    }
  }
  maximum_record_age_in_seconds      = var.kinesis_max_record_age
  maximum_batching_window_in_seconds = var.kinesis_batching_window
  bisect_batch_on_function_error     = var.kinesis_bisect_on_error
  parallelization_factor             = var.kinesis_parallelization_factor
  retry_strategy {
    maximum_retry_attempts = var.kinesis_consumer_max_retries
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-consumer-mapping"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "consumer_errors_alarm" {
  alarm_name          = "${var.kinesis_consumer_function_name}-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = var.kinesis_consumer_error_threshold
  alarm_description   = "This alarm triggers when Kinesis consumer Lambda has errors"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    FunctionName = aws_lambda_function.kinesis_consumer.function_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-errors"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "consumer_duration_alarm" {
  alarm_name          = "${var.kinesis_consumer_function_name}-duration"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "3"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.kinesis_consumer_duration_threshold
  alarm_description   = "This alarm triggers when Kinesis consumer Lambda duration exceeds threshold"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    FunctionName = aws_lambda_function.kinesis_consumer.function_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_consumer_function_name}-duration"
    Environment = var.environment
  })
}

resource "aws_cloudwatch_metric_alarm" "dlq_messages_alarm" {
  count               = var.enable_dlq_for_failed_messages ? 1 : 0
  alarm_name          = "${var.kinesis_stream_name}-dlq-messages"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "300"
  statistic           = "Maximum"
  threshold           = var.dlq_message_threshold
  alarm_description   = "This alarm triggers when there are messages in the Kinesis DLQ"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    QueueName = var.kinesis_dlq_name
  }

  tags = merge(var.common_tags, {
    Name        = "${var.kinesis_stream_name}-dlq-alarm"
    Environment = var.environment
  })
}

// === ARCHIVO: README.md ===
# Infraestructura Cloud para Big Data y HPC

## Descripción del Proyecto

Este repositorio contiene la definición de infraestructura como código (IaC) para un sistema de procesamiento de alto volumen diseñado para manejar 50,000 solicitudes por segundo con disponibilidad del 99.99%. La arquitectura implementa una landing zone multi-cuenta en AWS con segregación completa de red, patrones de alta disponibilidad y escalabilidad horizontal para cargas de trabajo de Big Data y computación de alto rendimiento (HPC).

## Arquitectura General

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           AWS Organizations                                 │
├─────────────────┬─────────────────┬─────────────────┬───────────────────────┤
│    Network      │   Shared        │   Workload      │   Security            │
│    Account      │   Services      │   (Dev/QA/Prod) │   Account             │
│    111111111111 │   222222222222  │   333333333333  │   444444444444        │
└────────┬────────┴────────┬────────┴────────┬────────┴───────────┬──────────┘
         │                 │                 │                    │
         ▼                 ▼                 ▼                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          Transit Gateway                                    │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
         ┌───────────────────────┼───────────────────────┐
         ▼                       ▼                       ▼
┌─────────────────┐   ┌─────────────────┐   ┌─────────────────┐
│   VPC Public    │   │   VPC Private   │   │   VPC Data      │
│   (App Tier)    │   │   (App Tier)    │   │   (Data Layer)  │
├─────────────────┤   ├─────────────────┤   ├─────────────────┤
│ • ALB/NLB       │   │ • ECS Cluster   │   │ • RDS Multi-AZ  │
│ • CloudFront    │   │ • EKS Cluster   │   │ • ElastiCache   │
│ • WAF           │   │ • Auto Scaling  │   │ • S3 Buckets    │
│ • NAT Gateway   │   │ • EC2 Spot      │   │ • DynamoDB      │
└─────────────────┘   └─────────────────┘   └─────────────────┘
                                 │
                                 ▼
                    ┌────────────────────────┐
                    │   Kinesis Data Streams  │
                    │   (Real-time Pipeline)  │
                    └────────────────────────┘
                                 │
         ┌───────────────────────┴───────────────────────┐
         ▼                                               ▼
┌─────────────────────────┐               ┌─────────────────────────┐
│   Kinesis Producer      │               │   Kinesis Consumer      │
│   (Data Ingestion)      │               │   (Kinesis Analytics)   │
└─────────────────────────┘               └─────────────────────────┘
```

## Componentes Principales

### Módulos de Infraestructura

| Módulo | Descripción | Recursos Principales |
|--------|-------------|----------------------|
| **network** | Segregación de red en capas públicas y privadas | VPC, Subnets, NAT Gateway, Internet Gateway, Route Tables, Transit Gateway |
| **compute** | Capa de cómputo con escalabilidad horizontal | EKS Cluster, ECS Cluster, Auto Scaling Groups, EC2 Spot Instances |
| **storage** | Almacenamiento cifrado y de alta disponibilidad | S3 Buckets (con versioning y lifecycle), EFS, EBS Volumes, DynamoDB |
| **security** | Seguridad integral y cumplimiento normativo | IAM Roles/Policies, KMS Keys, Security Groups, WAF Rules, Secrets Manager |
| **monitoring** | Observabilidad y alertas | CloudWatch Dashboards, Alarms, Log Groups, X-Ray, SNS Topics |
| **bigdata** | Pipeline de procesamiento en tiempo real | Kinesis Data Streams, Kinesis Data Firehose, Kinesis Analytics, Lambda |

### Ambientes

- **dev**: Configuración de desarrollo con recursos de menor capacidad y costos optimizados
- **qa**: Entorno de pruebas con configuración similar a producción pero sin redundancia completa
- **prod**: Producción con alta disponibilidad completa, multi-AZ y auto-scaling

## Prerequisitos

### Herramientas Requeridas

```bash
# Terraform >= 1.5.0
terraform version

# AWS CLI >= 2.0
aws --version

# jq (opcional, para scripts)
jq --version
```

### Configuración de Credenciales

El proyecto utiliza el backend de Terraform con estado remoto en S3. Configure las credenciales de AWS:

```bash
# Configurar perfil de AWS
aws configure --profile nombre-perfil

# O usar variables de entorno
export AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
export AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
export AWS_DEFAULT_REGION="us-east-1"
```

### Backend de Estado Remoto

El archivo `backend.tf` configura el almacenamiento del estado de Terraform en un bucket S3 con las siguientes características:

- Cifrado con KMS
- Versioning habilitado
- Bloqueo de eliminación (prevent_destroy)
- Locking con DynamoDB

## Comandos de Ejecución

### Inicialización

```bash
# Inicializar Terraform (sin backend para validación inicial)
terraform init -backend=false

# Validar configuración
terraform validate

# Formatear archivos
terraform fmt -check
```

### Planificación por Ambiente

```bash
# Desarrollo
cd environments/dev
terraform plan -var-file="terraform.tfvars"

# QA
cd environments/qa
terraform plan -var-file="terraform.tfvars"

# Producción
cd environments/prod
terraform plan -var-file="terraform.tfvars"
```

### Aplicar Infraestructura

```bash
# Desarrollo (inferior impacto)
cd environments/dev
terraform apply -var-file="terraform.tfvars" -auto-approve

# QA
cd environments/qa
terraform apply -var-file="terraform.tfvars" -auto-approve

# Producción (requiere aprobación manual)
cd environments/prod
terraform apply -var-file="terraform.tfvars"
```

### Destrucción

```bash
# Destruir recursos de desarrollo
cd environments/dev
terraform destroy -var-file="terraform.tfvars" -auto-approve

# Precaución en producción: siempre revisar el plan primero
cd environments/prod
terraform plan -var-file="terraform.tfvars" -destroy
terraform destroy -var-file="terraform.tfvars"
```

## Estructura de Archivos

```
.
├── README.md                          # Este archivo
├── main.tf                            # Orquestación principal
├── variables.tf                       # Declaraciones de variables
├── outputs.tf                         # Outputs del proyecto
├── providers.tf                       # Configuración de providers
├── backend.tf                         # Configuración de backend remoto
├── environments/
│   ├── dev/
│   │   └── terraform.tfvars          # Variables de desarrollo
│   ├── qa/
│   │   └── terraform.tfvars          # Variables de QA
│   └── prod/
│       └── terraform.tfvars          # Variables de producción
└── modules/
    ├── network/
    │   ├── main.tf                   # Recursos de red
    │   ├── variables.tf              # Variables del módulo
    │   └── outputs.tf                # Outputs del módulo
    ├── compute/
    │   ├── main.tf                   # Recursos de cómputo
    │   ├── variables.tf
    │   └── outputs.tf
    ├── storage/
    │   ├── main.tf                   # Recursos de almacenamiento
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security/
    │   ├── main.tf                   # Recursos de seguridad
    │   ├── variables.tf
    │   ├── outputs.tf
    │   └── iam_policies.tf           # Políticas IAM específicas
    ├── monitoring/
    │   ├── main.tf                   # Recursos de monitoreo
    │   ├── variables.tf
    │   └── outputs.tf
    └── bigdata/
        ├── main.tf                   # Recursos de Big Data
        ├── variables.tf
        ├── outputs.tf
        ├── kinesis.tf                # Configuración de Kinesis
        ├── kinesis_producer.tf       # Productores de datos
        └── kinesis_consumer.tf       # Consumidores de datos
```

## Convenciones de Código

### Versionado

- **Terraform**: Rango `>= 1.5.0` para permitir actualizaciones menores
- **Providers**: Rango `~> X.0` para mantener compatibilidad dentro de la versión mayor
- **Módulos**: Rango `~> X.0` para actualizaciones dentro de la misma versión mayor

### Nomenclatura de Recursos

- Recursos naming convention: `{proyecto}-{ambiente}-{componente}-{nombre}`
- Tags obligatorios: `Environment`, `Project`, `Owner`, `CostCenter`
- Security Groups: nombres descriptivos con sufijo `-sg`

### Políticas IAM

Todas las políticas IAM siguen el principio de menor privilegio:

- Permisos explícitos, nunca wildcards (`"*"`)
- Recursos específicos por nombre de ARn
- Condiciones para restringir por IP o tiempo
- Roles con confianza limitada a cuentas específicas

### Cifrado

- **En reposo**: Todos los buckets S3, volúmenes EBS, bases de datos RDS y tablas DynamoDB usan cifrado KMS
- **En tránsito**: TLS 1.2+ para todas las comunicaciones
- **Llaves de cifrado**: Políticas de rotación anual habilitadas

## Cumplimiento Normativo

### GDPR y CCPA

- Cifrado de datos personales en reposo y en tránsito
- Políticas de retención configuradas en buckets S3
- Logs de auditoría en CloudTrail
- IAM con principio de menor privilegio
- Redes privadas sin exposición directa a Internet

### Well-Architected Framework

La arquitectura sigue las mejores prácticas del AWS Well-Architected Framework:

- **Operational Excellence**: Infrastructure as Code, automatización, CloudWatch para monitoreo
- **Security**: IAM con menor privilegio, cifrado, WAF, aislamiento de red
- **Reliability**: Multi-AZ, Auto Scaling, backups automatizados, Recovery Point Objective (RPO) < 1 hora
- **Performance Efficiency**: Escalabilidad horizontal, servicios administrados, optimización de costos
- **Cost Optimization**: Reserved Instances para steady-state, Spot para flexible, S3 Lifecycle policies
- **Sustainability**: Right-sizing de recursos, instance types eficientes, automatización de inicio/parada

## Variables Principales

| Variable | Descripción | Tipo | Requerido |
|----------|-------------|------|-----------|
| `aws_region` | Región de AWS | string | sí |
| `environment` | Ambiente (dev/qa/prod) | string | sí |
| `project_name` | Nombre del proyecto | string | sí |
| `vpc_cidr` | Bloque CIDR de la VPC | string | sí |
| `availability_zones` | Zonas de disponibilidad | list(string) | sí |
| `enable_nat_gateway` | Habilitar NAT Gateway | bool | sí |
| `enable_vpn` | Habilitar VPN | bool | sí |
| `kinesis_shard_count` | Shards iniciales de Kinesis | number | sí |
| `eks_desired_capacity` | Capacidad deseada de EKS | number | sí |
| `enable_deletion_protection` | Habilitar protección contra eliminación | bool | sí |

## Outputs Principales

- `vpc_id`: ID de la VPC principal
- `eks_cluster_endpoint`: Endpoint del cluster EKS
- `s3_bucket_arns`: ARNs de buckets S3 configurados
- `kinesis_stream_arn`: ARN del stream de Kinesis
- `security_group_ids`: IDs de los grupos de seguridad
- `iam_role_arns`: ARNs de los roles IAM creados

## Troubleshooting

### Error: Provider Version Mismatch

Si aparece un error de versión del provider, actualice las restricciones en `providers.tf`:

```hcl
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }
}
```

### Error: Backend S3 No Configurado

Para entorno local sin acceso a S3, inicialice con backend local:

```bash
terraform init -backend=false
```

### Validación de Recursos

```bash
# Ver recursos que se crearán
terraform plan -out=plan.tfplan

# Mostrar gráfico de dependencias
terraform graph | dot -Tpng > graph.png
```

## Costos Estimados

Los costos mensuales aproximados (estimación inicial):

- **Desarrollo**: $500-1,000 USD/mes
- **QA**: $2,000-5,000 USD/mes
- **Producción**: $10,000-50,000+ USD/mes (dependiendo de carga de trabajo)

Consulte la calculadora de precios de AWS para estimaciones precisas.

## Contacto

Para dudas o problemas con la infraestructura, contacte al equipo de Cloud Ops.

// === ARCHIVO: environments/dev/terraform.tfvars ===
# Valores de variables para el ambiente de desarrollo
# Configuración optimizada para costos y pruebas funcionales

environment = "dev"

# Configuración de red - CIDR blocks para VPC
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]

# Configuración de disponibilidad
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
single_nat_gateway = true
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Instancias para desarrollo
instance_type = "t3.large"
min_instances = 2
max_instances = 4
desired_capacity = 2

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "m5.xlarge"
 eks_desired_capacity = 3
 eks_min_capacity = 2
 eks_max_capacity = 6

# Configuración de almacenamiento
storage_volume_size = 100
s3_bucket_versioning = true
enable_cross_region_replication = false

# Configuración de seguridad
enable_waf = false
enable_guardduty = false
enable_cloudtrail = true
kms_key_rotation = true

# Configuración de monitoreo
log_retention_days = 7
enable_detailed_monitoring = false
custom_metrics_enabled = true
alert_threshold_high = 80
alert_threshold_critical = 95

# Configuración de Big Data / Kinesis
kinesis_shard_count = 2
kinesis_retention_hours = 24
enable_kinesis_destination_logging = false

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-dev"
environment_tag = "development"
project_tag = "bigdata-hpc-platform"

// === ARCHIVO: environments/qa/terraform.tfvars ===
# Valores de variables para el ambiente de QA
# Configuración para pruebas de integración y rendimiento

environment = "qa"

# Configuración de red - CIDR blocks para VPC
vpc_cidr = "10.1.0.0/16"
public_subnet_cidrs = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
database_subnet_cidrs = ["10.1.20.0/24", "10.1.21.0/24", "10.1.22.0/24"]

# Configuración de disponibilidad - Multi-AZ para pruebas de HA
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
single_nat_gateway = false
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Capacidad media para QA
instance_type = "m5.2xlarge"
min_instances = 3
max_instances = 8
desired_capacity = 4

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "m5.2xlarge"
eks_desired_capacity = 4
eks_min_capacity = 3
eks_max_capacity = 10

# Configuración de almacenamiento
storage_volume_size = 500
s3_bucket_versioning = true
enable_cross_region_replication = false

# Configuración de seguridad - Habilitado para pruebas de cumplimiento
enable_waf = true
enable_guardduty = true
enable_cloudtrail = true
kms_key_rotation = true

# Configuración de monitoreo - Más detallado que dev
log_retention_days = 30
enable_detailed_monitoring = true
custom_metrics_enabled = true
alert_threshold_high = 75
alert_threshold_critical = 90

# Configuración de Big Data / Kinesis - Capacidad para pruebas de carga
kinesis_shard_count = 8
kinesis_retention_hours = 48
enable_kinesis_destination_logging = true

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-qa"
environment_tag = "qa"
project_tag = "bigdata-hpc-platform"

// === ARCHIVO: environments/prod/terraform.tfvars ===
# Valores de variables para el ambiente de producción
# Configuración de alta disponibilidad para SLA 99.99% y 50k TPS

environment = "prod"

# Configuración de red - CIDR blocks para VPC producción
vpc_cidr = "10.2.0.0/16"
public_subnet_cidrs = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
private_subnet_cidrs = ["10.2.10.0/24", "10.2.11.0/24", "10.2.12.0/24", "10.2.13.0/24", "10.2.14.0/24", "10.2.15.0/24"]
database_subnet_cidrs = ["10.2.20.0/24", "10.2.21.0/24", "10.2.22.0/24"]

# Configuración de disponibilidad - Alta disponibilidad completa
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
single_nat_gateway = false
enable_dns_hostnames = true
enable_dns_support = true

# Configuración de compute - Alta capacidad para 50k TPS
instance_type = "r6i.4xlarge"
min_instances = 10
max_instances = 50
desired_capacity = 20

# Configuración de EKS
cluster_version = "1.28"
node_instance_type = "r6i.4xlarge"
eks_desired_capacity = 15
eks_min_capacity = 10
eks_max_capacity = 50

# Configuración de almacenamiento - Alta capacidad y redundancia
storage_volume_size = 2000
s3_bucket_versioning = true
enable_cross_region_replication = true
replication_destination_region = "us-west-2"

# Configuración de seguridad - Cumplimiento completo GDPR/CCPA
enable_waf = true
enable_guardduty = true
enable_cloudtrail = true
kms_key_rotation = true
enable_macie = true
enable_security_hub = true

# Configuración de monitoreo - Observabilidad completa
log_retention_days = 90
enable_detailed_monitoring = true
custom_metrics_enabled = true
alert_threshold_high = 70
alert_threshold_critical = 85
enable_health_check = true
enable_canary_deployment = false

# Configuración de Big Data / Kinesis - Capacidad para producción
kinesis_shard_count = 64
kinesis_retention_hours = 168
enable_kinesis_destination_logging = true
kinesisEnhancedFanOut = true
kinesisConsumerCount = 4

# Configuración de recuperación ante desastres
enable_backup = true
backup_retention_days = 30
rto_minutes = 30
rpo_minutes = 5

# Configuración de etiquetas
owner_tag = "platform-team"
cost_center_tag = "infrastructure-prod"
environment_tag = "production"
project_tag = "bigdata-hpc-platform"
compliance_tag = "gdpr-ccpa"

```
