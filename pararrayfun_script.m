#{
Copyright 2024, fofolevrai

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS”
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#}
################################################################################
################################################################################
# To access 'parallel' package, run installation
# in your prompt shell once: 'pkg install -forge parallel'
#
# parallel package rely on 'struct' package. Do install if needed:
# 'pkg install -forge struct'
#
#
# 1.
# This example showcase the parallel call of a simplex function 'fun' present
# in the 'fun.m' file of this root directory.
#
# 2.
# It also show a calcuation intensive call of 'myfun' present in 'myfun.m' file
# of this root directory
#
# As a result, this example shows, due to parallel overhead, simplex function
# calculation isn't faster when parallized:
#{
>> pararrayfun_script
---- 'arrayfun @add' ----
{
  [1,1] = Sequential calculation time :
  [1,2] = 0.058801
}
---- 'pararrayfun @add' ----
{
  [1,1] = Parallel calculation time :
  [1,2] = 2.1209
}
---- 'arrayfun @myfun' ----
{
  [1,1] = Sequential calculation time :
  [1,2] = 11.295
}
---- 'pararrayfun @myfun' ----
{
  [1,1] = Parallel calculation time :
  [1,2] = 3.7105
}
#}
#
# Note : It is mandatory to declare Parallel functions in separated file
# of the same naming from the caller due to octave parallelisation instantiation.
# For more details :
# https://stackoverflow.com/questions/77352950/pararrayfun-could-not-receive-result-error-although-fun-returns-a-value

# Clear memory workspace
clear;
# Clear prompt
clc;

# Load required package(s)
pkg load parallel;

# fun is a simple addition calculation : y= x+a
# with x and a given arguments
# add = @(x, a) x+a;
nmax = 10000;
vector_x = 1:1:nmax;
vector_a = nmax:-1:1;

# Call function 'add' as sequential call
disp("---- 'arrayfun @add' ----");
tic();
vector_y = arrayfun(@add, vector_x, vector_a);
time_end = toc();
disp({"Sequential calculation time : ", time_end});

# Call function 'add' in concurrence call
disp("---- 'pararrayfun @add' ----");
tic();
vector_y = pararrayfun(nproc, @add, vector_x, vector_a);
time_end = toc();
disp({"Parallel calculation time : ", time_end});

# Call function 'myfun' as sequential call
disp("---- 'arrayfun @myfun' ----");
tic();
ni = 1:nmax;
[a, b] = arrayfun(@myfun, ni);
time_end = toc();
disp({"Sequential calculation time : ", time_end});

# Call function 'myfun' in concurrence call
disp("---- 'pararrayfun @myfun' ----");
tic();
ni = 1:nmax;
[c, d] = pararrayfun(nproc, @myfun, ni);
time_end = toc();
disp({"Parallel calculation time : ", time_end});

