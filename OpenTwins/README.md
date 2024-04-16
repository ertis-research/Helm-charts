<div align="center">
  <img src="https://github.com/ertis-research/opentwins/assets/48439828/74f974ba-3804-46de-9149-2c4fe7702e93" width="130" height="130" />

  <h3>OpenTwins</h3>
  <h4>Helm chart repository</h4>

</br>
<a href='https://ertis-research.github.io/opentwins' target="_blank"><img alt='Read the Docs' src='https://img.shields.io/badge/Docs-100000?style=for-the-badge&logo=Read the Docs&logoColor=000000&labelColor=33d9b2&color=40407a'/></a>
<a href='https://github.com/ertis-research/opentwins' target="_blank"><img alt='GitHub' src='https://img.shields.io/badge/github-100000?style=for-the-badge&logo=GitHub&logoColor=000000&labelColor=33d9b2&color=40407a'/></a>
</div>

</br>

First of all, you have to add ERTIS Research group helm repository to your helm repository list:

```bash
helm repo add ertis https://ertis-research.github.io/Helm-charts/
helm repo update
```

Once done, the next step is installing the chart by executing this line on your terminal (in our case, we will use `opentwins` as release name and `opentwins` as namespace, but you can choose the one that you prefeer). To customize the installation, please refer to [Helm's values](https://github.com/ertis-research/Helm-charts/blob/main/OpenTwins/values.yaml) file.

```bash
helm upgrade --install opentwins ertis/OpenTwins -n opentwins --wait --dependency-update
```

After waiting some time, the installation will be ready for use.

For more information about installation, please refer to the [documentation](https://ertis-research.github.io/opentwins/docs/installation/using-helm).
