# nwmRetro

This package is part of a working paper that compiles estimate flow volumes from the NWM retrospective v1.0 run at the NHD reach level. This package contains functionalites for  getting NHD subsets from the USGS WCS, joining the nwmRetro stats to that file, and writing it to disk in a number of formats. 

Future work will look at updating this dataset to the NWM retrospective v1.2 as well as including veleocity estimates.

## Basic Starting example

```
AOI = AOI::getAOI("Grand Canyon") %>% 
  find() %>% 
  write(file = '/Users/mikejohnson/Documents/GitHub/nwmRetro/data/test.gpkg')
```

To Do:

- [X]  Add data files
- [ ] Create a join function that attacahes data files to 'find' files before writing
