# Terraform EC2 Docker Host

Una utilidad en Terraform para desplegar una instancia EC2 económica (pero no dentro del tier gratuito) en AWS. Esta instancia está preparada para ejecutar aplicaciones usando `docker-compose`, con los puertos estándar abiertos para acceso remoto y web.

## 🛠️ ¿Qué hace este proyecto?

- Crea una instancia EC2 optimizada para bajo costo (por ejemplo, `t3a.small` o similar).
- Abre los puertos necesarios: 
  - `22` para SSH
  - `80` para HTTP
  - `443` para HTTPS
- Instala Docker y Docker Compose automáticamente.
- Permite desplegar aplicaciones fácilmente usando `docker-compose`.

## 📦 Requisitos

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- Una cuenta de AWS con credenciales configuradas
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (opcional)
- Clave SSH para acceder a la instancia

## 🚀 Cómo usar

1. **Clona este repositorio**

```bash
git clone https://github.com/Jose26Madrid/terraform.git
cd terraform-ec2-docker
