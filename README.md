# K8SLB

![](https://img.shields.io/docker/build/m4n3dw0lf/k8slb.svg)

**Kubernetes On-Premisse Load Balancer fully automized with Nginx**

- **Environment Variables**

|Name|Description|Example|
|-|-|-|
|**SERVER_NAME**| DNS of Load Balancer |k8s-cluster.acme.com |
|**PORT**| Port that nginx container will listen | 80 |
|**SERVICE_PORT**| K8s service port | 3000 |
|**NODE_{NUMBER}**| Nodes IPs, define as many node IPs as you want (must follow order starting by 1) | 10.0.0.10 |

- **Example**:

  - K8s cluster exposed service running on port 30115

  - 3 Nodes, 192.168.0.108 - 192.168.0.109 - 192.168.0.110

  ```
  docker run -it -e "SERVER_NAME=k8s-cluster.acme.com" \
  -e "PORT=80" \
  -e "SERVICE_PORT=30115" \
  -e "NODE_1=192.168.0.108" \
  -e "NODE_2=192.168.0.109" \
  -e "NODE_3=192.168.0.110" \
  m4n3dw0lf/k8slb
  ```

- **Output**:
```
LoadBalancer DNS: k8s-cluster.acme.com
LoadBalancer Port: 80
K8s Service Port: 30115
Adding Node: 192.168.0.108
Adding Node: 192.168.0.109
Adding Node: 192.168.0.110
LoadBalancer Configured Successfully!
```
