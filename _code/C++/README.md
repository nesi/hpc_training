---
layout: post
title: C++ code examples
permalink: /code/cpp-code/
chapter: code-samples
---

### How to compile C++ code in this directory

General instructions for Cray programming environment.

 1. Load/swap the programming environment of your choice, e..g. ```module swap PrgEnv-cray PrgEnv-intel```

 2. Invoke the ```CC``` compiler wrapper

 3. Add add include directories (```-I ...```), library directories (```-L...```) and libraries (```-l...```) as required.

## SimpleMpi

This example shows how to compile an MPI program, which prints "Hello world from processor X".

```
CC -o simpleMpiCXX simpleMpi.cxx
```
