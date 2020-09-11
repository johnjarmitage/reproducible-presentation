# An example of a Dockerfile to create a Notebook

This is very basic, and just an example. Run the following to get to the notebook from your terminal:

```commandline
docker build -t pommeroye:1.1 .
docker run -d -p 127.0.0.1:8888:8888 --name notebook pommeroye:1.1
docker logs --tail 3 notebook
```