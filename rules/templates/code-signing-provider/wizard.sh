#!/bin/bash

if [ "$TYPE" = "SoftHSM" ]; then
	mv ptxdist-set-keys-softhsm.sh ptxdist-set-keys.sh
	rm ptxdist-set-keys-hsm.sh

elif [ "$TYPE" = "HSM with OpenSC support" ] || [ "$TYPE" = "other HSM" ]; then
	mv ptxdist-set-keys-hsm.sh ptxdist-set-keys.sh
	rm ptxdist-set-keys-softhsm.sh
fi
