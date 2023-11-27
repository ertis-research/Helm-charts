# OpenTwins helm chart repository
## Instalation
First of all, you have to add our repository to your helm repository list:
```bash
helm repo add ertis https://ertis-research.github.io/Helm-charts/
```

Once done, the next step is installing the chart by executing this line on your terminal (in our case, we will use `opentwins` as release name, but you can choose the one that you prefeer):

```bash
helm upgrade --install opentwins ertis/OpenTwins --wait --dependency-update
```

After waiting some time, the installation is done, but you still need to configure several conections (we are working on making it automatic) as described on the [wiki](https://ertis-research.github.io/digital-twins-platform/).