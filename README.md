# Local Kubernetes GitOps Monorepo

Bu proje, yerel bir ortamda (Localhost) tam kapsamlı bir DevOps ve Platform Mühendisliği altyapısının "Infrastructure as Code" (IaC) ve "Configuration Management" prensipleriyle nasıl inşa edileceğini gösteren bir konsept kanıtıdır (PoC).

Altyapı provizyonu, K8s konfigürasyon yönetimi ve CI/CD süreçleri tek bir monorepo üzerinden yönetilmektedir.

## 🏗️ Mimari ve İş Akışı (Architecture)

Aşağıdaki diyagram, kodun yazılmasından uygulamanın cluster üzerinde ayağa kalkmasına kadar olan otomatik CI/CD sürecini göstermektedir:

```mermaid
graph TD
    subgraph "GitHub Cloud"
        A[Geliştirici Code Push] -->|Tetikler| B(GitHub Actions)
    end

    subgraph "Local Bare-Metal Server (CachyOS)"
        B -.->|İş Emri| C[Self-Hosted Runner]
        
        subgraph "Infrastructure Layer"
            C -->|1. IaC| D[Terraform]
            D -->|Provizyonlar| E[(Kind K8s Cluster)]
            E --- E1[Control Plane]
            E --- E2[Worker Node 1]
            E --- E3[Worker Node 2]
        end

        subgraph "Configuration & App Layer"
            C -->|2. Config| F[Ansible]
            F -->|K8s API İstekleri| E
            F -->|Deploy| G[Nginx Deployment]
        end
    end

    classDef default fill:#282a36,stroke:#6272a4,stroke-width:2px,color:#f8f8f2;
    classDef github fill:#181717,stroke:#ffffff,color:#fff;
    classDef runner fill:#ffb86c,stroke:#ff79c6,color:#282a36;
    class A,B github;
    class C runner;
