#!/bin/bash

./configure --prefix=${PREFIX} --without-jni --host=${HOST}

export CFLAGS="-O2 -Wl,-S ${CFLAGS}"

make -j${CPU_COUNT}
# skip tests on linux32 due to rounding error causing issues
if [[ ! ${HOST} =~ .*linux.* ]] || [[ ! ${ARCH} == 32 ]]; then
    make check -j${CPU_COUNT}
fi
make install -j${CPU_COUNT}

ACTIVATE_DIR=${PREFIX}/etc/conda/activate.d
DEACTIVATE_DIR=${PREFIX}/etc/conda/deactivate.d
mkdir -p ${ACTIVATE_DIR}
mkdir -p ${DEACTIVATE_DIR}

cp ${RECIPE_DIR}/scripts/activate.sh ${ACTIVATE_DIR}/proj4-activate.sh
cp ${RECIPE_DIR}/scripts/deactivate.sh ${DEACTIVATE_DIR}/proj4-deactivate.sh
cp ${RECIPE_DIR}/scripts/activate.csh ${ACTIVATE_DIR}/proj4-activate.csh
cp ${RECIPE_DIR}/scripts/deactivate.csh ${DEACTIVATE_DIR}/proj4-deactivate.csh
cp ${RECIPE_DIR}/scripts/activate.fish ${ACTIVATE_DIR}/proj4-activate.fish
cp ${RECIPE_DIR}/scripts/deactivate.fish ${DEACTIVATE_DIR}/proj4-deactivate.fish
