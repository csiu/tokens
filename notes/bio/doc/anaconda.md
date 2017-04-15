## [Anaconda](https://www.continuum.io/downloads)
- is a free Python distribution
- installation with `bash Anaconda*.sh`

### [Conda](http://conda.pydata.org/docs/index.html) package manager
- Create environments
```
conda create --name snowflakes biopython
```

- List all environments 
```
conda info --envs
```

- Switch environments
```
source activate bunnies
source deactivate
```

- List packages
```
conda list
```

- Install/Remove new/old package
```
conda install --name bunnies beautifulsoup4
conda remove --name bunnies iopro
```

- Remove environment
```
conda remove --name snakes --all
```

----

```
You can search for this package on anaconda.org with

    anaconda search -t conda <package>

You may need to install the anaconda-client command line client with

    conda install anaconda-client
```
