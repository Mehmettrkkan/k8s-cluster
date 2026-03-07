#!/bin/bash
# Bu betik, k8s cluster'ına tüm konfigürasyonları sırasıyla uygular.

echo "🚀 K8s Projesi Dağıtımı Başlıyor..."

# Klasördeki tüm .yaml uzantılı dosyaları ismine göre sıralayıp (01, 02 vb.) uygular
for f in *.yaml; do
    echo "📦 Uygulanıyor: $f"
    kubectl apply -f "$f"
done

echo "✅ Tüm dağıtımlar tamamlandı! Durumu kontrol etmek için 'kubectl get all -A' komutunu kullanabilirsiniz."
