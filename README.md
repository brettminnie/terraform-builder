Example 

```bash
$ docker run --rm -v `pwd`:/home/tools/data bdbstudios/terraform-builder bash -c "terragrunt plan"
# Alternately with a custom aws profile
$ docker run --rm -v `pwd`:/home/tools/data -v ~/.aws:/home/tools/.aws bdbstudios/terraform-builder bash -c "AWS_PROFILE=my_profile terragrunt plan"
# or as an env var
$ docker run --rm -v `pwd`:/home/tools/data -v ~/.aws:/home/tools/.aws -e AWS_PROFILE=my_profile  bdbstudios/terraform-builder bash -c "terragrunt plan"

```

Docker-compose example

Update the compose file to point to the root of your terraform dir

```yaml
volumes:
  - /path/to/your/terraform/directory:/home/terraform/data:z
```

Next run the service

```bash
$ docker-compose run terraform-builder
```