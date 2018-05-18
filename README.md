# Tuto orchestration de conteneurs avec Docker et Kubernetes

Ce tutoriel s'inspire du [container training](https://github.com/jpetazzo/container.training) mis en place par Jérôme Petazzoni.

Dans ce cas d'utilisation, nous allons remplacer les machines virtuelles en créant des nodes Kubernetes (ou K8s) à l'aide de conteneurs Docker provisionnés avec ```kubeadm```.

Faire tourner ```kubeadm``` dans un conteneur est en lui même un défi qui a déjà été traité [ici](https://github.com/kubernetes/kubeadm/issues/17). Il existe deux solutions :
- soit utiliser le Dockerfile et les instructions proposés [ici](https://github.com/kubernetes/kubeadm/issues/17#issuecomment-277540628)
- soit utiliser un projet appelé [kubeadm-dind-cluster](https://github.com/Mirantis/kubeadm-dind-cluster)

Puisque nous sommes dans un contexte pédagogique, nous allons implémenter la première solution.
