#! /bin/bash

CONTRACT_NAME="enu.system"

mkdir -p bin/${CONTRACT_NAME}
### BUILD THE CONTRACT
ENUCLANG="${PREFIX}/wasm/bin/clang++ -I${INSTALL_PREFIX}/include/libc++/upstream/include -I${INSTALL_PREFIX}/include/musl/upstream/include -I${INSTALL_PREFIX}/include -I./include -I../enu.token/include -I${BOOST}"
LINK="${PREFIX}/wasm/bin/llvm-link -only-needed "
LLC="${PREFIX}/wasm/bin/llc -thread-model=single --asm-verbose=false"
S2W="${INSTALL_PREFIX}/bin/enumivo-s2wasm "
W2W="${INSTALL_PREFIX}/bin/enumivo-wast2wasm "

${ENUCLANG}  -Iinclude -c -emit-llvm -O3 --std=c++14 --target=wasm32 -nostdinc -DBOOST_DISABLE_ASSERTS -DBOOST_EXCEPTION_DISABLE -nostdlib -nostdlibinc -ffreestanding -nostdlib -fno-threadsafe-statics -fno-rtti -fno-exceptions -o ${CONTRACT_NAME}.bc src/${CONTRACT_NAME}.cpp
${LINK} -o linked.bc ${CONTRACT_NAME}.bc ${INSTALL_PREFIX}/usr/share/enumivo/contractsdk/lib/enulib.bc ${INSTALL_PREFIX}/usr/share/enumivo/contractsdk/lib/libc++.bc ${INSTALL_PREFIX}/usr/share/enumivo/contractsdk/lib/libc.bc
${LLC} -o ${CONTRACT_NAME}.s linked.bc
${S2W} -o ${CONTRACT_NAME}.wast -s 16384 ${CONTRACT_NAME}.s
${W2W} ${CONTRACT_NAME}.wast bin/${CONTRACT_NAME}/${CONTRACT_NAME}.wasm -n
cp abi/${CONTRACT_NAME}.abi bin/${CONTRACT_NAME}/${CONTRACT_NAME}.abi
cp ${CONTRACT_NAME}.wast bin/${CONTRACT_NAME}/${CONTRACT_NAME}.wast

rm ${CONTRACT_NAME}.bc linked.bc ${CONTRACT_NAME}.wast ${CONTRACT_NAME}.s
