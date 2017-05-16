# AppleALC_Instructions
Complete instructions for AppleALC.kext

AppleALC Intructions

Redesign AppleHDA to its codec

Before you start studying AppleHDA, you need to familiarize yourself with the concept of injecting layout.

1. Extracting Linux - Dump
Starting from the Linux LiveCD drive (for example Ubuntu, Parted Magic ....) go to the folder / proc / asound / card0 / card # 0 or card # 2 this is a text file of the Linux dump.

or in terminal

cat /proc/asound/card0/codec#0 > ~/Desktop/codec_dump.txt
(or)
cat /proc/asound/card0/codec#1 > ~/Desktop/codec_dump.txt
(or)
cat /proc/asound/card0/codec#2 > ~/Desktop/codec_dump.txt

2. Analysing the codec dump
2.1 Codec information
We need the following details from the codec dump:
1. Codec
2. Address
3. Vendor Id (Convert this hex value into decimal value)
4. Pin Complex Nodes with Control Name
5. Audio Mixer/Selector Nodes
6. Audio Output Nodes
7. Audio Input Nodes

Details for the example ALC269 from the codec dump:
1. CODEC : Realtek ALC269VB
2. ADDRESS : 0
3. VENDOR ID : Hex: 0x10ec0269 [Decimal: 283902569]
4. PIN COMPLEX NODES WITH CONTROL NAMES :
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Control: name="Speaker Playback Switch", index=0, device=0
ControlAmp: chs=3, dir=Out, idx=0, ofs=0
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x00010014: OUT EAPD Detect
EAPD 0x2: EAPD
Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
Conn = ATAPI, Color = Unknown
DefAssociation = 0x1, Sequence = 0x0
Misc = NO_PRESENCE
Pin-ctls: 0x40: OUT
Unsolicited: tag=00, enabled=0
Connection: 2
0x0c* 0x0d

Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
Control: name="Mic Boost Volume", index=0, device=0
ControlAmp: chs=3, dir=In, idx=0, ofs=0
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
Amp-In vals: [0x00 0x00]
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x80 0x80]
Pincap 0x00001734: IN OUT Detect
Vref caps: HIZ 50 GRD 80
Pin Default 0x04a11820: [Jack] Mic at Ext Right
Conn = 1/8, Color = Black
DefAssociation = 0x2, Sequence = 0x0
Pin-ctls: 0x24: IN VREF_80
Unsolicited: tag=08, enabled=1
Connection: 1
0x0d

Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
Control: name="Internal Mic Boost Volume", index=0, device=0
ControlAmp: chs=3, dir=In, idx=0, ofs=0
Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
Amp-In vals: [0x03 0x03]
Pincap 0x00001724: IN Detect
Vref caps: HIZ 50 GRD 80
Pin Default 0x99a3092f: [Fixed] Mic at Int ATAPI
Conn = ATAPI, Color = Unknown
DefAssociation = 0x2, Sequence = 0xf
Misc = NO_PRESENCE
Pin-ctls: 0x24: IN VREF_80
Unsolicited: tag=00, enabled=0

Node 0x21 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Control: name="Headphone Playback Switch", index=0, device=0
ControlAmp: chs=3, dir=Out, idx=0, ofs=0
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x0000001c: OUT HP Detect
Pin Default 0x0421101f: [Jack] HP Out at Ext Right
Conn = 1/8, Color = Black
DefAssociation = 0x1, Sequence = 0xf
Pin-ctls: 0xc0: OUT HP
Unsolicited: tag=04, enabled=1
Connection: 2
0x0c 0x0d*

5. AUDIO MIXER/SELECTOR NODES:
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
Connection: 5
0x18 0x19 0x1a 0x1b 0x1d

Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Connection: 2
0x02 0x0b

Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00 0x00] [0x00 0x00]
Connection: 2
0x03 0x0b

Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x00] [0x00]
Connection: 2
0x02 0x0b

Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
Amp-In caps: N/A
Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
Connection: 7
0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12

Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-In vals: [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
Connection: 6
0x18 0x19 0x1a 0x1b 0x1d 0x0b

6. AUDIO OUTPUT NODES :
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
Control: name="Speaker Playback Volume", index=0, device=0
ControlAmp: chs=3, dir=Out, idx=0, ofs=0
Device: name="ALC269VB Analog", type="Audio", device=0
Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
Amp-Out vals: [0x41 0x41]
Converter: stream=5, channel=0
PCM:
rates [0x560]: 44100 48000 96000 192000
bits [0xe]: 16 20 24
formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
Control: name="Headphone Playback Volume", index=0, device=0
ControlAmp: chs=3, dir=Out, idx=0, ofs=0
Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
Amp-Out vals: [0x41 0x41]
Converter: stream=5, channel=0
PCM:
rates [0x560]: 44100 48000 96000 192000
bits [0xe]: 16 20 24
formats [0x1]: PCM

7. AUDIO INPUT NODES :
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
Control: name="Capture Switch", index=0, device=0
Control: name="Capture Volume", index=0, device=0
Device: name="ALC269VB Analog", type="Audio", device=0
Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x1e 0x1e]
Converter: stream=1, channel=0
SDI-Select: 0
PCM:
rates [0x560]: 44100 48000 96000 192000
bits [0xe]: 16 20 24
formats [0x1]: PCM
Connection: 1
0x23

Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
Control: name="Capture Switch", index=1, device=0
Control: name="Capture Volume", index=1, device=0
Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
Amp-In vals: [0x00 0x00]
Converter: stream=0, channel=0
SDI-Select: 0
PCM:
rates [0x560]: 44100 48000 96000 192000
bits [0xe]: 16 20 24
formats [0x1]: PCM
Connection: 1
0x22

2.2 Extracting the values 'Pin Default', 'EAPD' and 'Node ID' from the Pin Complex Nodes
We have analysed and got the relevant details from the codec dump in sections 1 through 2.1. Now, we try to get the values of Pin Default, EAPD and Node ID from the Pin Complex nodes with Control Name extracted above.

For the example ALC269:-
Pin Complex Nodes with Control Name
Node 14 : Pin Default 0x99130110, EAPD: 0x02
Node 18 : Pin Default 0x04a11820
Node 19 : Pin Default 0x99a3092f
Node 21 : Pin Default 0x0421101f

Extracting the verb data:
We will get the verb data from the Pin Default values of Nodes.

Pin default values must be read from right to left. And we will take two digits from it and write it down from left to right like below explained for ALC269.
Node 14:
Pin Default value: 0x99130110
Extracted verb data: "10 01 13 99"

Node 18:
Pin Default value: 0x04a11820
Extracted verb data: "20 18 a1 04"

Node 19:
Pin Default value: 0x99a3092f
Extracted verb data: "2f 09 a3 99"

Node 21:
Pin Default value: 0x0421101f
Extracted verb data: "1f 10 21 04"

Now, we need to correct the above verb data according to verbs info explained in the second post. 
at Node 14: 10 01 13 99 [ Correction 99->90(Note 1)]
at Node 18: 20 18 a1 04 [ Correction 18->10(Note 2)]
at Node 19: 2f 09 a3 99 [ Correction 2f->20(Note 3) 09->01(Note 2) 99->90(Note 1)]
at Node 21: 1f 10 21 04 [ Correction 1f->10(Note 3)]
at Node 14 EAPD : 02 (Note 5) 

Corrected Verb Data:
Code:
at Node 14: 10 01 13 90
at Node 18: 20 10 a1 04
at Node 19: 20 01 a3 90
at Node 21: 10 10 21 04
at Node 14 EAPD : 02
Verb data after default association corrections: Note 4
at Node 14: 10 01 13 90
at Node 18: 20 10 a1 04
at Node 19: 30 01 a3 90
at Node 21: 40 10 21 04
at Node 14 EAPD : 02
Final Verb data after Mic corrections: Note 6 and Note 7
Node 14: 10 01 13 90
Node 18: 20 10 81 04
Node 19: 30 01 a0 90
Node 21: 40 10 21 04
Node 14 EAPD : 02

Note 1: Location correction (9x)
Apple uses the location value as Built in Device - N/A instead of ATAPi in their codecs, which is always '0 ' for the location bit for the Integrated devices(Speakr, Int Mic). This is optional and audio will work if we use default codec value also. Just changing this to be more like Apple codec so we can avoid any future issues.
 
Ex:- at Node 14: 10 01 13 90 (Speaker) [ Changed from 9 to 0]
at Node 19: 30 01 a0 90 (Int Mic) [ Changed from 9 to 0]
 
Note 2: Jack color and sense capability correction (xx)
For internal devices like speakers etc., we use the jack color value as '0'(unknown) and need to Jack sense value of '1'.
For external devices like Headphones etc.,  we use the jack color value as '1'(black) and need to Jack sense value of '0'.
In this jack color may be optional, but Jack sense must use the values i've explained.
 
Note 3: Sequence correction (Ax)
We have to set this value to '0' for every device because Apple don't use analog multi out.
We have corrected above 2f and 1f values to 20 and 10 by replacing f with 0 in our example, so this Sequence number(Second digit) value must be always 0 for every node and A is the associate bit value of the node which is unique for each node.
 
Note 4: Default association correction (x0)
The Default association bit in the codec verbs must not match with other devices, so the association bit must be unique for all the devices.
 
Here, We have same association bit for both Speakers and Headphone as "1" and for both Mic's as "2", so we have to correct this default association bit. Most importantly the association bit must be in sequence and serially like assigning 1,2...x to the Nodes in sequence.
For example:- '1' to node 14, '2' to node 18 in sequence, '3' to Node 19 in sequence and '4' to Node 21 in sequence to previous node 19.
The association bit value can either 1 2 3â€¦.. d.e.f.
 
Note 5: EAPD existence
We have to look carefully at the output nodes like Speaker and Headphone, since in some codecs there is an External Amplifier(EAPD) to power up/down the Speaker to save power. We need to use EAPD command to wake up the node to get the sound otherwise we won't get sound even though its recognized.
 
Note 6: Internal Mic correction
If you did not get the "Ambient noise reduction" working for the Internal mic then you have to correct the "Connection type" bit field to Unknown Code Value(i.e, 0). In our example, we have the value 'a3' for the mic and corrected to 'a0'.
 
Note 7: External Mic correction
Here, we have to correct the external mic verb data to LineIn, otherwise the external mic won't work with AppleHDA.So, the verb data needs to be corrected at the position where it tells what kind of device it is.

Existing verb data for External Mic is "ax", where 'a' tells its Mic In. Now, we change this to Line in with 'ax' is replaced by '81' .
 
For more information about the codec verbs info:Click Here.

3 Calculating the PathMaps
 
To calculate the PathMaps, we have to carefully follow the connections mentioned in every node from the analyzed relevant nodes information.
 
For output Devices, the PathMap follows this pattern
We have to find a Pin Complex node, an Audio Mixer node (optional for some codecs) and finally an Audio output node.
Pin Complex -> Audio Mixer -> Audio Output
(or)
Pin Complex ->  Audio Output

For Input Devices, the PathMap follow this pattern
We have to find a Pin Complex node, an Audio Mixer/Selector node (optional for some codecs) and finally an Audio input node.
Pin Complex -> Audio Selector/Mixer -> Audio Input
(or)
Pin Complex -> Audio Input

3.1 Output device PathMap calculation
Lets first calculate the PathMaps for the output devices speaker and Headphone in our example ALC269.
 
According to the output device PathMap pattern, first we need to find Pin Complex node. In our ALC269 example, the output device 'Speaker' is located at the Pin Complex Node 0x14 with the Control Name "Speaker Playback Switch". Write down this Pin Complex node value in hex and decimal value.
0x14 , Decimal - 20

Now, take a look at the Connection in the Node 0x14.
We have two connections to nodes 0x0c and 0x0d, but the connection 0x0c has an asterisk symbol(*) indicating that this node 0x14 has a real connection to the node 0x0c which is an Audio Mixer needed according to our PathMaps pattern,  so write down this node value in sequence
0x14->0x0c, Decimal - 20->12

Again, take a look at the node 0x0c we reached from the node 0x14. Here, we have two more nodes 0x02 and 0x0b without asterisk symbol(*) indicating the path where it goes. So, we have to figure out ourself and choose one from the two nodes. To solve this, just take a look at the two Nodes 0x02 and 0x0b.
For the output device PathMap, we already have two nodes out of three required except Audio Output Node. In our case 0x02 node is the Audio Output, so write this value in the sequence
0x14->0x0c->0x02, Decimal - 20->12->2

Now, we have calculated PathMap for the output device speaker.
 
Similarly, take a look at the Pin Complex Node 0x21 which is also an another output device "HeadPhone Playback switch". If we calculate the PathMap just like speaker and we will get
0x21->0x0d->0x03, Decimal - 33->13->3

Now, we have calculated PathMap for the output device Headphone.
 
NOTE: 
If both Pin Complex nodes have connection to same Audio output node then try to use the other output node we analyzed from codec dump and test. sometimes using same output node for both also works.
 
 
3.2 Input device PathMaps calculation
Calculating the pathMaps for input devices is little different from the output devices because connections are not mentioned and doesn't follow similar to output nodes. So, in this case we have go through the PathMap pattern from "Audio input" to "Pin Complex node" instead from "Pin Complex node" to "Audio Input" like we did for Output devices.

Like this,
	1	First go to the Audio input node and look at the connections to the nodes Audio Mixer/Selector from here.
	2	Follow the connection which will lead us to Audio Mixer/Selector
	3	At Audio Mixer/Selector, Look at the Connections for the "*" symbol on Pin complex node
	4	If it contains the symbol "*" then that is the Pin Complex node it is connected to, so got the PathMap of Pin Comple Node->Audio Mixer/Selector->Audio Input we needed.
	5	If it does not contain then compare the results of the other Audio Input node ->Audio Mixers/Selector for the symbol "*". Even that Audio Mixer/Selector node also don't has symbol "*" then try to experiment with the available options of Pin complex node to Audio Selector/Mixer nodes (or) look at the Pin Complex node connections to Audio Selector/Mixer nodes.
 
Lets calculate the PathMaps for the example of ALC 269. 
 
I've followed the Audio input (Node#9) Connection to Audio Selector(Node#22) then to Audio Input (Node#18) because of the symbol "*" on that node indicating default path.
0x09->0x22->0x18 => 0x18->0x22->0x09

Again, followed Audio input (Node#8) Connections to Audio Mixer(Node#23). But, i did not find the symbol "*" here to show the path. However, i've followed to Pin complex (Node#19) because its the only Input device we left with and even the connections of the Node#22 contains a Connection to Node#19 as well.
0x08->0x023->0x19 => 0x19->0x23->0x08
 
PathMaps for the Output and Input Devices of ALC269:
Pin Complex->Audio Mixer->Audio Output (Hex values)
Speaker : 20-> 12-> 2 (0x14->0x0c->0x02)
HeadPhone : 33-> 13-> 3 (0x21->0x0d->0x03)

Pin Complex->Audio Selector/Mixer->Audio Input(Hex values)
Internal Mic : 25-> 35-> 8 (0x19->0x23->0x08)
External Mic : 24-> 34-> 9 (0x18->0x22->0x09)

3b 1 Drawing of the graphic scheme from a dump (Hex -> Dec converting text Linux dump and graphic scheme)
* Download and install Graphviz: http://www.graphviz.org/Download_macos.php
* Download and unpack to the desktop scripts: https://dl.dropbox.com/s/lqzc5pzo8nyh0j2/HD_Codec-convert.zip?dl=1

Using the terminal, run the script Codec.txt_convert.sh, upon request of the script, drag your codec dump to the terminal window.

A new folder is created on the desktop that contains the following files:
* The original codec dump in hexadecimal form (hex)
* Codec dump in decimal form (dec)
* Graphic scheme in hex
* Graphics in dec
* Pin-complex (with them it is convenient to make a pin-config)

3b 2 Constructing chains of nodes (for output to columns)
Sequences of strings of nodes:

In-out1-out2
￼

Example - The output of Didi from the decimal (dec) graphic scheme ACL887:

￼

The arrows indicate the chain: 20 -> 12 -> 2

Example is slightly more difficult - Headphone output, codec VIA2021
￼



Here in the chain there is Audio Selector: 40 -> 27 -> 52 -> 11.

4. Making a minimum pin-config (for output to the speakers)
To create a pin-config you will need the original Linux-dump (hex).
The scheme for composing pin-config:
Address + Node + 71c + [78] Address + Node + 71d + [56] Address + Node + 71e + [34] Address + Node + 71f + [12]
Where Address - is taken from the original dump, it happens 0 or 2.
Node - the number of the pin-complex, take from the original dump.
The numbers [78] [56] [34] [12] are substituted from the following list.

For desktops:
F0 00 00 40 - unused (disabled) pin complex
10 40 11 01 - built-in speaker
20 40 21 01 - headphones
60 90 A0 90 - Built-in microphone
70 90 81 01 - front microphone (disguised as a line input)
80 30 81 01 - Line In
90 61 4B 01 - SPDIF-Out - digital optical output
A0 01 СB 01 - SPDIF-In - digital optical input

Additional line outputs (needed if you use 5.1 or 7.1 sound):
30 60 01 01 - Orange line out (Orange)
40 20 01 01 - Line output in gray (Gray)
50 10 01 01 - Black line out (Black)

For laptops:
10 10 13 99 - Built-in speaker
60 01 A0 90 - Built-in microphone


Example 1: ALC269
In the original dump, I find the Address of my codec:
Codec: Realtek ALC269
Address: 0

In the same dump, I'm looking for a pin-complex of speakers, according to the criteria:
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Control: name="Speaker Playback Switch", index=0, device=0
ControlAmp: chs=3, dir=Out, idx=0, ofs=0
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x00010014: OUT EAPD Detect
EAPD 0x2: EAPD
Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
Conn = ATAPI, Color = Unknown
DefAssociation = 0x1, Sequence = 0x0
Misc = NO_PRESENCE
Pin-ctls: 0x40: OUT
Unsolicited: tag=00, enabled=0
Connection: 2
0x0c* 0x0d

The initial data are found, we begin to compose the pin-complex of the speakers.
For the Pin Complex Node 14:
0 + 14 + 71c + 10 = 01471c10
0 + 14 + 71d + 01 = 01471d01
0 + 14 + 71e + 13 = 01471e13
0 + 14 + 71f + 90 = 01471f90

01471c10 01471d01 01471e13 01471f90

In the same way we describe all pin-complexes, below I will show how the pin-complex of a microphone is described.
We write out all the pin-complexes and block everything unused (at this stage everything except 0x14).
Disable pin-complexes (F0 00 00 40).


For the Pin Complex Node 18:
01871c20 01871d10 01871e81 01871f04

For the Pin Complex Node 19:
01971c30 01971d01 01971ea0 01971f90

For the Pin Complex Node 21:
02171c40 02171d10 02171e21 02171f04

In our ALC269 example, there is an EAPD at Node 14 of Speaker. So, we need to calculate the verb command for this EAPD and use in our patch to get sound from speaker.
 
For EAPD at Node 14:
0 + 14 +70c + 02 = 01470c02
Now, we assemble the calculated codec verb commands so we can use for AppleHDA patch.
<01471c10 01471d01 01471e13 01471f99 01470c02
01871c20 01871d10 01871ea1 01871f04
01971c30 01971d01 01971ea3 01971f99
02171c40 02171d10 02171e21 02171f04>

Final codec verb commands with disabled nodes are:
<01271cf0 01271d00 01271e00 01271f40
01471c10 01471d01 01471e13 01471f90 01470c02
01771cf0 01771d00 01771e00 01771f40
01871c20 01871d18 01871e81 01871f04
01971c30 01971d10 01971ea0 01971f90
01a71cf0 01a71d00 01a71e00 01a71f40
01b71cf0 01b71d00 01b71e00 01b71f40
01d71cf0 01d71d00 01d71e00 01d71f40
01e71cf0 01e71d00 01e71e00 01e71f40
02171c40 02171d10 02171e21 02171f04>

Example 2: ALC887.
In the original dump, I find the Address of my codec:
Codec: Realtek ALC887-VD
Address: 0

In the same dump, I'm looking for a pin-complex of speakers, according to the criteria:
[Jack] Line Out at Ext Rear (Line Out on the Rear Panel)
and
Conn = 1/8, Color = Green (green)
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line-Out Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x01014410: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
    0x0c

The initial data are found, we begin to compose the pin-complex of the speakers.
01471C10 01471D40 01471E11 01471F01
In the same way we describe all pin-complexes, below I will show how the pin-complex of a microphone is described.
To prevent errors at this (initial) stage, it is sufficient to describe only one node. Disable the remaining pin-complexes (F0 00 00 40).
We write out all the pin-complexes, we block everything except 0x14.

01171CF0 01171D00 01171E00 01171F40
01271CF0 01271D00 01271E00 01271F40
01471C10 01471D40 01471E11 01471F01
01571CF0 01571D00 01571E00 01571F40
01671CF0 01671D00 01671E00 01671F40
01771CF0 01771D00 01771E00 01771F40
01871CF0 01871D00 01871E00 01871F40
01971CF0 01971D00 01971E00 01971F40
01A71CF0 01A71D00 01A71E00 01A71F40
01B71CF0 01B71D00 01B71E00 01B71F40
01C71CF0 01C71D00 01C71E00 01C71F40
01D71CF0 01D71D00 01D71E00 01D71F40
01E71CF0 01E71D00 01E71E00 01E71F40
01F71CF0 01F71D00 01F71E00 01F71F40

After following all the above steps, we get the verb commands and PathMaps for the codec. 

5. Layoutxx.xml file Patching
From 10.8 or later, the xml files are compressed to zlib format. We have to uncompress them to edit the files. After editing, again we have to compress it back to zlib.
 
For Compressing and uncompressing, use the attached perl script and below commands in terminal:

for uncompressing
perl zlib.pl inflate layout28.xml.zlib > layout28.xml

for compressing
perl zlib.pl deflate layout28.xml > layout28.xml.zlib


Unpack your layoutXX.xml.zlib script pack-unpack-zlib.sh.
For a single output on the speakers my layout99.xml looks like this:

￼

Red lines indicate:
* The selected layout ID = 99 (it must also appear in the file name)
* Codec ID = 283904135 (to take from the decimal line-dump)
* PathMapID can be substituted for any, but in order to avoid confusion, I recommend using the same one as in Layout ID.

Green underscores denotes the devices used, in this case the Speakers, the above is the description of the device, below, in Outputs all types of used outputs are registered, in this case only the speakers.

Inputs in this case is empty.

It should also be taken into account that if only one output to the speakers is described, then in Platforms.xml there should be only one chain of nodes for output to the speakers and in the pin-config it is necessary to describe only one this output, the rest of the inputs / outputs to block , Otherwise it's a mistake and there will be no sound.

Next, Layout99.xml with all inputs / outputs:

￼

Green underlined exits, yellow entrances.
Blue denotes the parameter MuteGPIO, details in section 5.2

5.1. How to choose the right Layout?
This is also an important point, because if your layout is not selected correctly - the sound will not start.
The correct layout is the one that Apple uses, their list can be found in the AppleHDA driver directory: ~ / AppleHDA.kext / Contents / Resources, for clarity I show the picture:

￼



If in doubt choose - use layout12 (hex: 0x0C) not to be mistaken;)

5.2. MuteGPIO 
This parameter is responsible for enabling / disabling the microphone.
If the node of your microphone is present in the table, simply overwrite the value from the table in MuteGPIO.

￼

Most often, HD codecs use a value of 80.
My node is 0x18 (hex) -> 24 (dec), respectively for 80% - hex: 0x50010018 -> dec: 1342242840.
If there is no node in the table, then this value can be calculated:
MuteGPIO consists of: VREF hex + 0100 + Node ID
Define VREF hex: open the dump -> Node 0x18, there is a line Vref caps: HIZ 50 GRD 80 100
VREF 80 dec = 0x50 hex
Hex 0x50010018 translate to dec, get 1342242840
And prescribe MuteGPIO

￼




5.3 Patching
You can either use the attached xml files (or) can choose any one of the layout xml file from the apple Resources directory inside AppleHDA kext that matches Inputs and outputs of your codec and try this only if you want to experiment.
 
I'm using the Layout28.xml of Apple and edited to the values of ALC269. One of the reason to choose layout28 is because its used in MacBookPro8,1 and works very well. The other layout id's which also works for some codecs are '1' and '12' in hackintosh.
 
Note: We removed the tags External Mic, SPDIF from the Apple layout28 xml file since they are not needed for our example ALC269.
 
In the Layout xml file, we have to edit the following information.
 
1. LayoutID
<key>LayoutID</key>
<integer>28</integer> 

2. CodecID [ALC 269 Vendor id decimal value =283902569 ]
<key>CodecID</key>
<array>
  <integer>283902569</integer>
</array>
 
3. Edit the Inputs key like below for External Mic(LineIn) and Internal Mic in Notebooks
<key>Inputs</key>
<array>
   <string>Mic</string>
   <string>LineIn</string>
</array>
 
4. Edit the "IntSpeaker" key  like below and remove all the signal processing elements.
Note: set MuteGPIO to 0 (or) remove this if its not working [ not supported by some codecs]

For Realtek:
<key>IntSpeaker</key>
<dict>
    <key>MaximumBootBeepValue</key>
    <integer>48</integer>
    <key>MuteGPIO</key>
    <integer>0</integer>
</dict>

For others:
<key>IntSpeaker</key>
<dict>
    <key>MaximumBootBeepValue</key>
    <integer>110</integer>
</dict>

5. Edit the "LineIn" key  like below. 
For Realtek:
<key>LineIn</key>
<dict>
     <key>MuteGPIO</key>
     <integer>1342242840</integer>
</dict>

For Others:
<key>Mic</key>
<dict/>

6.  Edit the "Mic" key like below. 
For Realtek:
<key>Mic</key>
<dict>
     <key>MuteGPIO</key>
     <integer>1342242841</integer>
</dict>

For Others:
<key>LineIn</key>
<dict/>
 
7. Edit the Outputs key like below for Speakers and Headphone in Notebooks
<key>Inputs</key>
<array>
  <string>Headphone</string>
  <string>IntSpeaker</string>
</array>

8. Edit the PathMapID tag at the end of the file with the PathMapID value used in Platforms xml file.
<key>PathMapID</key>
<integer>269</integer>
Note: SignalProcessing elements for Mic and Speaker are not supported by some codecs, so i've removed it. But can provide some good audio if used but not sure, so try to experiment with this later after getting audio working. I've attached xml files with the SignalProcessing working fine in ALC269 for speaker and Mic in Realtek and IDT for your reference, you can get more from Apple xml files.


6 Platforms.xml Patching
 
This file contains the Mapping of Controls to its nodes giving a path. These path maps are contained in the key tag "<key>PathMaps</key>".
 
Note:You can use the Platforms xml file i've attached which has all the PathMaps of Apple codec are removed and has only one PathMap of ALC269 in order to make it easy for editing instead of Apple file.
 
We need to add our pathMaps to this root key which is a mapping of our Pin Complex's(O/P & I/P) to its Output/Input controls.
 
Follow the pattern i've explained below and edit the values of your codec nodes PathMaps calculated in the first post for each input and output. After editing then add the PathMap pattern of yours inside the file Platforms.xml at the end after the key tag of PathMapID like below.

<key>PathMapID</key>
   <integer>[some apple id]</integer>
</dict>
<<< Your pathMaps >>

The pattern for the PathMap is
<dict>
     <key>PathMap</key>
            <array>
                <array>
                    <array>
                      Data of Input1 (LineIn)
                    </array>
                    <array>
                      Data of Input2 (Mic)
                    </array>
                </array>
                <array>
                    <array>
                      Data of Output1 (Speaker)
                    </array>
                    <array>
                      Data of Output2 (Headphone)
                    </array>
                </array>
            </array>
            <key>PathMapID</key>
            <integer>[PathMapID used in layout#]</integer>
     </dict>
 
Input Data pattern: 
<array>
    <dict>
        <key>Amp</key>
        <dict>
            <key>Channels</key>
            <array>
                <dict>
                    <key>Bind</key>
                    <integer>1</integer>
                    <key>Channel</key>
                    <integer>1</integer>
                </dict>
                <dict>
                    <key>Bind</key>
                    <integer>2</integer>
                    <key>Channel</key>
                    <integer>2</integer>
                </dict>
            </array>
            <key>MuteInputAmp</key>
            <true/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <true/>
        </dict>
        <key>NodeID</key>
        <integer>[Input Node#]</integer>
    </dict>
    <dict>
        <key>NodeID</key>
        <integer>[Audio Mixer/Selector Node#]</integer>
    </dict>
    <dict>
        <key>Boost</key>
        <integer>[Boost value# 1-3]</integer>
        <key>NodeID</key>
        <integer>[Pin complex Node#]</integer>
    </dict>
</array>

Input Data pattern without Audio Mixer/Selector:
Note: Some codecs doesn't  need (or) use Audio Mixer/Selector node, so in order to get them working we should remove it from the pattern. Mostly this has been seen from IDT and Conexant codecs so far by me.
<array>
    <dict>
        <key>Amp</key>
        <dict>
            <key>Channels</key>
            <array>
                <dict>
                    <key>Bind</key>
                    <integer>1</integer>
                    <key>Channel</key>
                    <integer>1</integer>
                </dict>
                <dict>
                    <key>Bind</key>
                    <integer>2</integer>
                    <key>Channel</key>
                    <integer>2</integer>
                </dict>
            </array>
            <key>MuteInputAmp</key>
            <true/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <true/>
        </dict>
        <key>NodeID</key>
        <integer>[Input Node#]</integer>
    </dict>
    <dict>
        <key>Boost</key>
        <integer>[Boost value# 1-3]</integer>
        <key>NodeID</key>
        <integer>[Pin complex Node#]</integer>
    </dict>
</array>

Output data pattern:
<array>
    <dict>
        <key>Amp</key>
        <dict>
            <key>MuteInputAmp</key>
            <false/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <false/>
        </dict>
        <key>NodeID</key>
        <integer>[Pin complex Node#]</integer>
    </dict>
    <dict>
        <key>Amp</key>
        <dict>
            <key>MuteInputAmp</key>
            <true/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <false/>
        </dict>
        <key>NodeID</key>
        <integer>[Audio Mixer Node#]</integer>
    </dict>
    <dict>
        <key>Amp</key>
        <dict>
            <key>Channels</key>
            <array>
                <dict>
                    <key>Bind</key>
                    <integer>1</integer>
                    <key>Channel</key>
                    <integer>1</integer>
                </dict>
                <dict>
                    <key>Bind</key>
                    <integer>2</integer>
                    <key>Channel</key>
                    <integer>2</integer>
                </dict>
            </array>
            <key>MuteInputAmp</key>
            <true/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <false/>
        </dict>
        <key>NodeID</key>
        <integer>[Output Node#]</integer>
    </dict>
</array>

Output Data pattern without Audio Mixer:
Note: Some codecs doesn't  need (or) use Audio Mixer, so in order to get them working we should remove it from the pattern. Mostly this has been seen from IDT and Conexant codecs so far by me.
<array>
    <dict>
        <key>Amp</key>
        <dict>
            <key>MuteInputAmp</key>
            <false/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <false/>
        </dict>
        <key>NodeID</key>
        <integer>[Pin complex Node#]</integer>
    </dict>
    <dict>
        <key>Amp</key>
        <dict>
            <key>Channels</key>
            <array>
                <dict>
                    <key>Bind</key>
                    <integer>1</integer>
                    <key>Channel</key>
                    <integer>1</integer>
                </dict>
                <dict>
                    <key>Bind</key>
                    <integer>2</integer>
                    <key>Channel</key>
                    <integer>2</integer>
                </dict>
            </array>
            <key>MuteInputAmp</key>
            <true/>
            <key>PublishMute</key>
            <true/>
            <key>PublishVolume</key>
            <true/>
            <key>VolumeInputAmp</key>
            <false/>
        </dict>
        <key>NodeID</key>
        <integer>[Output Node#]</integer>
    </dict>
</array>


Substitution of chains in Platforms.xml.zlib
The basic rule of making chains: First you need to register the Inputs (Microphones, line inputs), then the Outputs (Dynamics, Headphones, other Line outputs, etc.) are preset.

* Run pack-unpack-zlib.sh on the request of the script, move Platforms.xml.zlib to the terminal window, Enter. After that, the file Platforms.xml.plist appeared in the directory and can be edited using the Property List Editor.app.

￼


For a basis I take PathMapID for example with number 15, all other PathMapes I delete not to get confused in them, also I optimize the chosen PathMap:
* Remove from it all the chains except one (the one that I'll use to output to the speakers).
* I enter earlier assigned PathMapID 99 (same as Layout)
* Instead of the existing Nods, I enter my own, previously mined 20 -> 12 -> 2
* I move the AMP to the desired node (See section 7.1)
After all these manipulations, the following picture emerged:


￼

* For packaging the finished xml, use the same script pack-unpack-zlib.sh

7.1. AMP layout is also Amplifier (amplifier)

The general rule for configuring Amp is:
We find in the nodes of the line Amp-In and Amp-Out, look at the values ​​of nsteps and mute.
Amp-In
Mute = 0 corresponds to MuteInputAmp = false, mute = 1 - MuteInputAmp = true
Nsteps = 0 - VolumeInputAmp = false otherwise true
If the pin-complex output nsteps = 3 then this is not Amp and Boost = 3
Amp-out
Mute = 0 - PublishMute = false otherwise true
Nsteps = 0 - PublishVolume = false otherwise true

Consider the example. The chain of 20 - 12 - 2, here is their description from the dec - dump:
Node 2 [Audio Output] wcaps 1053: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC887-VD Analog", type="Audio", device=0
  Amp-Out caps: ofs=64, nsteps=64, stepsize=3, mute=0
  Amp-Out vals:  [64 64]
  Converter: stream=8, channel=0
  PCM:
    rates [1376]: 44100 48000 96000 192000
    bits [14]: 16 20 24
    formats [1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 12 [Audio Mixer] wcaps 2097419: Stereo Amp-In
  Amp-In caps: ofs=0, nsteps=0, stepsize=0, mute=1
  Amp-In vals:  [0 0] [0 0]
  Connection: 2
    2 11
Node 20 [Pin Complex] wcaps 4195725: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line-Out Jack", index=0, device=0
  Amp-Out caps: ofs=0, nsteps=0, stepsize=0, mute=1
  Amp-Out vals:  [0 0]
  Pincap 65598: IN OUT HP EAPD Detect Trigger
  EAPD 2: EAPD
  Pin Default 16860176: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 1, Sequence = 0
  Pin-ctls: 64: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
    12

Node 20 has a string:
Amp-Out caps: ofs = 0, nsteps = 0, stepsize = 0, mute = 1
Nsteps = 0 corresponds PublishVolume = false
Mute = 1 corresponds to PublishMute = true

Noda 12:
Amp-In caps: ofs = 0, nsteps = 0, stepsize = 0, mute = 1
Nsteps = 0 corresponds to MuteInputAmp = false
Mute = 1 corresponds to VolumeInputAmp = true

Noda 2:
Amp-Out caps: ofs = 64, nsteps = 64, stepsize = 3, mute = 0
Nsteps = 64 corresponds PublishVolume = true
Mute = 0 matches PublishMute = false

Result:
.￼

Next, look at the input - microphone:
Node 9 [Audio Input] wcaps 1049883: Stereo Amp-In
  Control: name="Capture Switch", index=1, device=0
  Control: name="Capture Volume", index=1, device=0
  Device: name="ALC887-VD Analog", type="Audio", device=2
  Amp-In caps: ofs=16, nsteps=46, stepsize=3, mute=1
  Amp-In vals:  [128 128]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [1376]: 44100 48000 96000 192000
    bits [14]: 16 20 24
    formats [1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
    34
Node 25 [Pin Complex] wcaps 4195727: Stereo Amp-In Amp-Out
  Control: name="Front Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Jack", index=0, device=0
  Amp-In caps: ofs=0, nsteps=3, stepsize=39, mute=0
  Amp-In vals:  [0 0]
  Amp-Out caps: ofs=0, nsteps=0, stepsize=0, mute=1
  Amp-Out vals:  [128 128]
  Pincap 14142: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 44145760: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 6, Sequence = 0
  Pin-ctls: 36: IN VREF_80
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
    12* 13 14 15 38
Node 34 [Audio Mixer] wcaps 2097419: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Amp-In caps: ofs=0, nsteps=0, stepsize=0, mute=1
  Amp-In vals:  [0 0] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128] [128 128]
  Connection: 12
    24 25 26 27 28 29 20 21 22 23 11 18

Node 9:
Amp-In caps: ofs = 16, nsteps = 46, stepsize = 3, mute = 1
Nsteps = 46 corresponds to MuteInputAmp = true
Mute = 1 corresponds to VolumeInputAmp = true

Node 34:
Amp-In caps: ofs = 0, nsteps = 0, stepsize = 0, mute = 1
Nsteps = 0 corresponds PublishVolume = false
Mute = 1 corresponds to PublishMute = true

Noda 25:
Amp-In caps: ofs = 0, nsteps = 3, stepsize = 39, mute = 0
Nsteps = 3 on the pin-output complex means Boosts = 3

Result:
￼ut.

7.2. Auto Detect Speakers and Headphones
Some equivalent devices are logically connected to an auto detect, for example, when headphones are connected, the sound goes to the headphones and the speakers are turned off, and the rear microphone is turned off when the front is connected.

￼

In the figure, red arrows indicate the rear and front microphones, blue - Speakers and Headphones.

7.3. Front panel does not work
Probably the reason is corny - the HD connector is not connected to the motherboard. Board.
If the connector is connected, maybe it is made according to the AC97 standard then you can forget about the auto detect.
Checking to which standard the front panel is the easiest in Winds: If the front panel auto detection is active and monitoring shows the connected connector, the front panel supports the HD standard. If the front panel needs to be turned off and it works autonomously from the rear panel, the front panel supports the AC97 standard.

The connectors HD and AC97 can be externally different and partially interchangeable (a muzzle of the standard AC97 can be connected to the motherboard of the standard HD). The control of I / O switching in the codec is different. If in AC97 switching is done mechanically, then in HD - electronically, by the codec itself.

Of course, you can visually distinguish the connectors of the connection.
For example: the connection connector refers exactly to the AC97 standard, if each wire of the connection connector is made as a separate pin.

￼
￼

But it also happens that the AC97 connector is made in the form of one shoe, the differences: In the muzzle cable AC97, the pins 4 and 8 (key) are free on the connector, and only the 8th pin (key) in the muzzle cable of the HD standard.

AC97 Connector
￼

HD Connector
￼

If it turns out that your AC97 sound panel, you can still make it work.

Decision number 1. In the previous paragraph (about the autodetect) it is described how to connect the chains of nodes to an auto-detective, but if you do not have an auto-detection system supported by the panel, then you do not need to auto-detect either in the driver, and disconnect if the chains are unified. In this case you will be able to manually switch the outputs:

￼


Also, if there is a desire, there are instructions for reworking AC97 in HD, links:
Http://people.overclockers.ru/EvgenijV/record2
or
Http://1.789saturn.ru/?p=1
For education through AC97, I thank comrade BIM167


8. EAPD
After all the previous steps of the instruction are executed, in System Settings -> Sound: all Inputs and Outputs are displayed, the volume control in the top menu bar is active but there is no sound - you need to check your outputs for EAPD.

￼


In this figure, you can see that EAPD is present on nodes 20 -> 0x14 (hex) and 27 -> 0x1B (hex), and therefore in the pin configuration you need to add these nodes to the additional willow:
Speakers:
01471C10 01471D40 01471E11 01471F01 01470C02

TimeWalker said (a):
01470C02 is verb for enabling EAPD on a 0x14 node (speakers). Without this, there is no sound from the speakers, even though everything is determined
02 - EAPD Status Update
70C - Extra Verb Base
14 - Speaker Node
0 - Codec Number.

Headphones:
01B71C20 01B71D40 01B71E21 01B71F01 01B70C02

9. Codec Verbs Info

071CXY
X = Default Association
Values: 1, 2, 3, 4, 5, 6, 7, 8, 9, a, b, c, d and f

Y = Sequence 
Values: Always set this to '0' because Apple dont use analog multi outputs in their codec.

071DXY
X = Color: Color of the jack
Values: 
Unknown 0
Black 1
Grey 2
Blue 3
Green 4
Red 5
Orange 6
Yellow 7
Purple 8
Pink 9
Reserved A-D
White E
Other F

Y = Misc - Jack detect sensing capability
Values:
1 for Internal Devices(Speaker etc.,) and
0 for External Devices(Headphones etc.,)

071EXY
X = Default device - Intended use of the Jack
Values:
Speakers 1
HP Out 2
CD 3
SPDIF Out 4
Digital Other Out 5
Modem Line Side 6
Modem Handset Side 7
Line In 8
AUX 9
Mic In A
Telephony B
SPDIF In C
Digital Other In D
Reserved E
Other F

Y = Connection type - indicates the type of physical connection
Values:
Unknown 0
1/8 stereo/mono 1
1/4 stereo/mono 2
ATAPI internal 3
RCA 4
Optical 5
Other Digital 6
Other Analog 7
Multichannel Analog (DIN) 8
XLR/Professional 9
RJ-11 (Modem) A
Combination B
Other F

071FXY
X = Port Connectivity - indicates the external connectivity of the Pin Complex.

Software can use this value to know what Pin Complexes are connected to jacks, internal devices, or not connected at all.

00b - The Port Complex is connected to a jack (1/8, ATAPI, etc.).
01b - No physical connection for Port.
10b - A fixed function device (integrated speaker, integrated mic, etc.) is attached.
11b - Both a jack and an internal device are attached.


Y = Location
Location indicates the physical location of the jack or device to which the pin complex is connected. This allows software to indicate, for instance, that the device is the â€œFront Panel Headphone Jackâ€ as opposed to rear panel connections.


Details:
Convert the 2 digit hex number to binary.
Pad the front with zeros to make it 8 dgits.

Example:
Code: 0x02 = binary 10 = 00000010 8 digit binary
Reading the bits from left to right:

Port Connectivity bits 7:6
-----------------------------------------------------------
00 - Port is connected to a Jack

01 - No External Port -or- No physical connection for Port**

10 - Fixed Function/Built In Device (integrated speaker, mic, etc)

11 - Jack and Internal device are attached


Location Part 1 - bits 5:4
-----------------------------------------------------------
00 - External on primary chassis

01 - Internal

10 - Separate chassis

11 - Other


Location Part 2 - bits 3:0
-----------------------------------------------------------
The meaning depends on Location Part 1

00 0000****N/A

00 0001** Rear

00 0010** Front

00 0011** Left

00 0100** Right

00 0101** Top

00 0110** Bottom

00 0111** Special (Rear panel)

00 1000** Special (Drive bay)



01 0000** N/A

01 0111** Special (Riser)

01 1000** HDMI

01 1001** ATAPI



10 0000****N/A

10 0001** Rear

10 0010** Front

10 0011** Left

10 0100** Right

10 0101** Top

10 0110** Bottom



11 0000** N/A

11 0110** ?

11 0111** Inside Mobile Lid (example: mic)

11 1000** Outside Mobile Lid



************Bits

Hex******76 54 3210
-------------------
71cf01 = 00 00 0001 - Port has a jack - It is External - Rear Location

71cf02 = 00 00 0010 - Port has a jack - It is External - Front Panel Location

71cf59 = 01 01 1001 - No External Port - ATAPI

71cf18 = 00 01 1000 - Port has a jack - External - HDMI

71cf90 = 10 01 0000 - Built In Device - Internal - N/A

******** |**|**||||

******** |**|**|--------- Location part 2

******** |**|------------ Location part 1**

******** |--------------- Port Connectivity
