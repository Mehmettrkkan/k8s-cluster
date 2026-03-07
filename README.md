# K8s Gelişmiş Cluster Yönetimi ve DevSecOps Ortam Kurulumu

Bu proje, 5 node'lu (1 Master, 4 Worker) bir Kubernetes cluster üzerinde uçtan uca mimari kurulumunu içermektedir. Proje kapsamında namespace izolasyonu, RBAC (Rol Tabanlı Erişim Kontrolü) ile yetkilendirme, Ingress Controller yapılandırması, StatefulSet ve DaemonSet dağıtımları gerçekleştirilmiştir.

## 🚀 Kullanılan Teknolojiler
* **Ortam:** Minikube (Docker Driver)
* **İşletim Sistemi:** CachyOS (Arch Linux)
* **Bileşenler:** Nginx Ingress, WordPress, MySQL (Persistent Volumes), Fluentd, MongoDB
* **Kavramlar:** RBAC, Node Affinity, Liveness/Readiness Probes, Rolling Updates

## 📂 Proje Yapısı
* `01-namespaces.yaml`: Test ve Production ortamlarının izolasyonu.
* `02-rbac.yaml`: Junior ve Senior ekipler için yetkilendirmeler.
* *(Diğer dosyaları buraya ekledikçe güncelleyeceğiz)*

## ⚙️ Hızlı Kurulum
Tüm YAML dosyalarını sırasıyla çalıştırmak için `deploy.sh` betiğini kullanabilirsiniz:
```bash
./deploy.sh
