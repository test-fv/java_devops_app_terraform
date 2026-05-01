# 🚀 CI/CD + Terraform + Azure VM (Mono-Repo)

Este proyecto implementa una arquitectura completa de **Infraestructura como Código (IaC)** y **CI/CD**, utilizando:

* Terraform (Azure)
* GitHub Actions
* Docker
* Azure Container Registry (ACR)
* Azure Virtual Machine (VM)

El objetivo es lograr un flujo completamente automatizado donde:

```text
Código → Build → Push (ACR) → Deploy (VM)
```

---

# 🧠 Arquitectura

El sistema sigue un modelo desacoplado:

```text
Terraform → define infraestructura
VM → ejecuta deploy (deploy.sh)
Pipeline → orquesta el proceso
```

### Flujo general:

```text
Developer push
↓
Pull Request → validaciones + terraform plan
↓
Merge a main
↓
Terraform aplica infraestructura (con aprobación)
↓
Build aplicación + push a ACR
↓
SSH a VM → ejecuta deploy.sh
↓
Aplicación disponible
```

---

# 📁 Estructura del Proyecto

```text
repo-root/
│
├── .github/workflows/
│   ├── pull-request-checks.yml
│   ├── infra-terraform.yml
│   └── app-delivery.yml
│
├── app/
│   ├── src/
│   ├── pom.xml
│   └── Dockerfile
│
├── terraform/
│   ├── environments/prod/
│   └── modules/
│       ├── resource_group/
│       ├── network/
│       ├── acr/
│       └── vm/
│
└── README.md
```

---

# ⚙️ Infraestructura (Terraform)

Terraform crea y configura:

* Resource Group
* Virtual Network + Subnet
* Network Security Group (puertos 22 y 80)
* Azure Container Registry (ACR)
* Virtual Machine Ubuntu 22.04
* IP pública estática

---

# 🖥️ Configuración automática de la VM

Mediante `cloud-init`, la VM se crea lista para despliegue:

* Docker instalado y activo
* Azure CLI instalado
* Carpeta `/home/azureuser/app`
* Script `deploy.sh`

---

# 📜 deploy.sh (núcleo del despliegue)

Este script es el encargado del despliegue real:

```bash
docker pull <imagen>
docker stop/remove contenedor
docker run nueva versión
```

👉 El pipeline NO hace deploy directamente
👉 Solo ejecuta este script vía SSH

---

# 🔁 Pipelines (GitHub Actions)

## 1️⃣ Pull Request Checks

* Ejecuta tests
* Ejecuta `terraform plan`
* Valida cambios antes de merge

---

## 2️⃣ Infra Terraform

* Ejecuta `plan`
* Requiere aprobación manual
* Ejecuta `apply`

---

## 3️⃣ Application Delivery

* Construye la aplicación
* Genera imagen Docker
* Hace push a ACR
* Obtiene outputs de Terraform
* Ejecuta `deploy.sh` en la VM vía SSH

---

# 🔐 Secrets requeridos

Configurar en GitHub:

```text
AZURE_CREDENTIALS   → Service Principal
VM_SSH_KEY          → clave privada SSH
```

---

# 📤 Outputs de Terraform

Usados por el pipeline:

```text
vm_ip      → IP pública de la VM
acr_name   → nombre del ACR
```

---

# 🚀 Cómo ejecutar

## 1. Inicializar Terraform

```bash
cd terraform/environments/prod
terraform init
terraform plan
terraform apply
```

---

## 2. Subir cambios

```bash
git checkout -b feature/mi-cambio
git push
```

* Crear Pull Request
* Validar pipeline
* Hacer merge

---

## 3. Deploy automático

Después del merge:

* Infra se actualiza
* Imagen se construye
* Se despliega automáticamente en la VM

---

# ⚠️ Consideraciones importantes

```text
✔ La VM tiene IP estática
✔ El deploy está centralizado en deploy.sh
✔ Terraform es la fuente de verdad
✔ No se usan secrets para ACR_NAME
✔ No hay lógica duplicada de deploy
```

---

# 🧠 Decisión de arquitectura

Se eligió el modelo:

```text
VM inteligente (deploy.sh)
Pipeline orquestador
```

Ventajas:

* Desacople entre CI/CD y despliegue
* Reutilización del script
* Posibilidad de ejecutar deploy manual
* Mayor control del entorno runtime

---

# 🔮 Próximos pasos

Mejoras posibles:

* Health checks en deploy.sh
* Rollback automático
* Zero-downtime deployment
* Managed Identity (eliminar login manual)
* Migración a Kubernetes

---

# 🏁 Estado del proyecto

```text
✔ Infraestructura declarativa
✔ CI/CD funcional
✔ Deploy automatizado
✔ Arquitectura desacoplada
✔ Lista para entorno real
```

---

# 👨‍💻 Autor

Proyecto diseñado como práctica avanzada de:

* Terraform
* CI/CD
* Azure
* DevOps real

---

# ⭐ Nota final

Este proyecto no es solo una demo, sino una base sólida de cómo se construye un sistema real de despliegue automatizado en entornos profesionales.
