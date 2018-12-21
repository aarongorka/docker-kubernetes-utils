# docker-kubernetes-utils

Docker image with `kubectl` and other useful Kubernetes utilities

## Why?

This image is used when following the [3 Musketeers] pattern. By running `kubectl` inside Docker, we ensure consistency, control and confidence.

  * Consistency: when developing automated processes that use `kubectl`, you can be sure that they will function the same whether you run it on your Windows workstation or on a Jenkins build agent.
  * Control: by specifying the version of the image in [docker-compose.yml][], we can deploy to two incompatible versions of Kubernetes simultaneously.
  * Confidence: reliable deployments build confidence in the use of CI/CD pipelines, creating a positive feedback loop that encourages developers to use CI/CD

[3 Musketeers]: https://3musketeers.io/


## How To Use

Makefile:
```Makefile
deploy:
	docker-compose run --rm kubectl apply -f k8s-config/deployment.yml
```

docker-compose.yml:
```yaml
services:
  kubectl:
    image: aarongorka/kubernetes-utils:1.10.3
    volumes:
      - .:/srv/app:Z
      - ~/.kube:/root/.kube:Z
    working_dir: /srv/app
```
