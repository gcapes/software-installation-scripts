#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct  3 15:05:32 2018

@author: mbexegc2
"""

from netCDF4 import Dataset
rootgrp = Dataset("test.nc", "w", format="NETCDF4")
print(rootgrp.data_model)
rootgrp.close()