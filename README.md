<img width="2816" height="1536" alt="mimari2" src="https://github.com/user-attachments/assets/e9d0c2a4-ef4a-47e7-beca-365c9dda490b" />
# Kubernetes Uçtan Uca Cluster Mimarisi 

Bu proje, 5 node'lu (1 Master, 4 Worker) bir Kubernetes cluster üzerinde, test ve production ortamlarının izole edildiği, siber güvenlik prensiplerine (RBAC, Least Privilege) uygun ve yüksek erişilebilirliğe (High Availability) sahip bir sistem mimarisi kurulumunu içermektedir.

## Proje Özeti
Proje kapsamında, web uygulamaları (WordPress & MySQL) ve veritabanı kümeleri (MongoDB) için gerekli olan ağ yönlendirmeleri, kalıcı depolama alanları ve yetkilendirme mekanizmaları sıfırdan inşa edilmiştir. Sistem, yük altında kendi kendini iyileştirebilen (Self-healing) ve kesintisiz güncellenebilen (Rolling Update) bir yapıda kurgulanmıştır.

## Mimari ve Güvenlik (DevSecOps) Yaklaşımı
* **İzolasyon:** Geliştirme (Test) ve Canlı (Production) ortamları Namespace bazında tamamen ayrıştırılmıştır.
* **Yetkilendirme (RBAC):** Junior ve Senior ekipler için "En Az Ayrıcalık" prensibine uygun roller (Role ve ClusterRoleBinding) tanımlanmıştır.
* **Kaynak ve Donanım İzolasyonu:** Node Affinity ve Taint/Toleration mekanizmaları kullanılarak, kritik canlı ortam podlarının sadece belirli sunucularda (worker node) çalışması garanti altına alınmıştır.
* **Gizlilik:** Veritabanı parolaları ve hassas veriler YAML dosyalarından arındırılıp, Base64 şifrelemeli K8s Secret objeleri ile yönetilmiştir.
* **Denetim ve Loglama:** Cluster genelindeki tüm logları merkezi olarak toplamak için Fluentd, DaemonSet olarak konumlandırılmıştır.
* **Servis Hesapları (Service Accounts):** Pod içi API sömürülerini (Privilege Escalation) engellemek adına, API ile konuşacak podlara sadece "okuma" yetkisine sahip özel hizmet hesapları atanmıştır.

## Kullanılan Teknolojiler
* **Konteyner Orkestrasyonu:** Kubernetes (Minikube / Docker Driver)
* **İşletim Sistemi:** CachyOS (Arch Linux)
* **Ağ ve Trafik Yönetimi:** Nginx Ingress Controller, LoadBalancer, Headless Services
* **Veritabanı ve Stateful Yapılar:** MySQL (PVC ile), MongoDB (StatefulSet)
* **Sağlık Kontrolleri:** Liveness ve Readiness Probes

## Proje Klasör Yapısı ve Adımlar
1. `01-namespaces.yaml` - Test ve Production ortamlarının oluşturulması.
2. `02-rbac.yaml` - Gruplar arası yetki sınırlandırmalarının (RoleBinding) yapılması.
3. `03-config.yaml` - Secret (Şifre yönetimi) ve PVC (Kalıcı depolama) ayarları.
4. `04-deployments.yaml` - Pod/Node Affinity ile WordPress ve MySQL dağıtımları.
5. `05-ingress.yaml` - Domain tabanlı (testblog & companyblog) trafik yönlendirmeleri.
6. `06-probes-lb.yaml` - Sağlık provaları, LoadBalancer ve Rolling Update stratejileri.
7. `07-daemonset.yaml` - Log toplama (Fluentd) ajanlarının dağıtımı.
8. `08-statefulset.yaml` - Kimlikli ve özel disk alanlı MongoDB cluster kurulumu.
9. `09-service-account.yaml` - Özel yetkilendirilmiş Service Account ile K8s API etkileşimi.

## Operasyonel Komutlar (Örnekler)
* **Node Tahliyesi (Sıfır Kesinti ile Bakım):**
  `kubectl drain <node-adi> --ignore-daemonsets --delete-emptydir-data --force`
* **Pod Ölçeklendirme (Scale Up/Down):**
  `kubectl scale deployment probe-deployment --replicas=10 -n production`
* **İmaj Güncelleme (Rolling Update):**
  `kubectl set image deployment/probe-deployment app-container=ozgurozturknet/k8s:v2 -n production`
