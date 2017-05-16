#!/bin/bash
#
# Declaration of variables
THIS_SCRIPT_PATH=$(dirname $0);

echo "Script File Location - $THIS_SCRIPT_PATH";
# Check for availability 2-convert_hex_to_dec.rb
if ! [ -f $THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb ] ; then
echo "Additional script 2-convert_hex_to_dec.rb not found";
exit
else echo "2-convert_hex_to_dec.rb найден"
fi
		if ! [ -d $THIS_SCRIPT_PATH/1-codecgraph ] ; then 
		echo "Catalog 1-codecgraph not found";
		exit
		else echo "Catalog 1-codecgraph found"
		fi
			read -p "Drag your Linux audio dump to the Terminal window and press ENTER: " n
			if [ $n ]; then
				
			CODEC_FILE_NAME=$(basename ${n});
			FOLDER_PATH=$(dirname ${n});
			
			
			echo "The path to the codec file - ${n}";
			echo "Codec file name - $CODEC_FILE_NAME";
			
			mkdir ~/Desktop/"$CODEC_FILE_NAME"_converts/;
			
			touch ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			
			cd ~/Desktop/"$CODEC_FILE_NAME"_converts/;
									
			cp ${n} ~/Desktop/"$CODEC_FILE_NAME"_converts/;
			
			$THIS_SCRIPT_PATH/1-codecgraph/codecgraph ${n};
			$THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb ${n} > "$CODEC_FILE_NAME"_dec.txt
			$THIS_SCRIPT_PATH/2-convert_hex_to_dec.rb "$CODEC_FILE_NAME".svg > "$CODEC_FILE_NAME"_dec.svg
			
			ADDRESS=$(sed -n '/Address:/{p;}' ${n});
			CODEC=$(sed -n '/Codec:/{p;}' ${n});
			VENDOR=$(sed -n '/Vendor Id:/{p;}' ${n});
			VNDR_DEC=$(sed -n '/Vendor Id:/{p;}' ${CODEC_FILE_NAME}_dec.txt);
			PIN_COMPLEX=$(sed -n '/Pin Complex/{p;}' ${n});
			
			echo "$ADDRESS" > ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$CODEC" >> ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$VENDOR" >> ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "Dec $VNDR_DEC" >> ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			echo "$PIN_COMPLEX" >> ~/Desktop/"$CODEC_FILE_NAME"_converts/pin-complex.txt;
			
			echo "The data is located on the desktop, in the directory: "$CODEC_FILE_NAME"_converts";
			
			echo "$ADDRESS"
			echo "$VENDOR"
			echo "Dec $VNDR_DEC"
			echo "$PIN_COMPLEX"
			exit
		fi