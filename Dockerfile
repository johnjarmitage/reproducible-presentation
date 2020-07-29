# This container is based on the jupyter scipy notebook as it already has the basic dependencies instaled
FROM jupyter/scipy-notebook:76402a27fd13

# Now I copy my files accross to the container
# Because of the base image I need to be more precise on where I copy them to.
# (https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html#preparing-your-dockerfile)
USER root
COPY apt.txt .

# pyvista is tricky, I need some extra linux libraries. Jupyter docker images are ubuntu based, so I use apt-get to install these linux dependencies
RUN apt-get install -f apt.txt

COPY environment.yml ${HOME}
COPY start ${HOME}
COPY presentation.ipynb ${HOME}
# I then change ownership of the files to the notebook user
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}



# I do a conda install the python dependencies for the notebook
RUN conda update -n base conda
RUN conda install --quiet --yes -c conda-forge --file environment.yml

# Finally for pyvista to function I need to run a script at startup
ENTRYPOINT ["/bin/sh", "start"]