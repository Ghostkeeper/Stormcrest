Bill of Materials
-----------------
These are the necessary materials to build this pinball machine. Sources and prices are written down to be correct upon the time of committing the change (see `git blame` to find the time and date). The total cost is a simple sum of these costs at various times and dates and will not be correct if any prices change during the time of development. It should give a good approximation of the cost of this build though.

As long as the design of the machine is not yet complete, this bill will also not yet be complete.

About Closed-Source Hardware
----------------------------
Not all hardware in this bill is open source, mostly because of my lack of skill in the area of electronics forcing me to buy something more common with better documentation on the internet rather than something uncommon that is open source. Here I make an attempt at discussing ways to find open source alternatives if you so choose. This is a list of the closed-source components in the machine.

| Item                   | Notes                                                                                                                                                              |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Lolin Wemos D1 Mini v3 | Used to control the LED matrix. It needs a sufficiently powerful chip with plenty of memory and 8 data output pins. Maybe an Olimex ESP8266 chip would replace it? |

Software
--------
Only free and open source software was used to build this machine. This software supports Windows, MacOS and Linux.

The cost of these tools is not counted in the final sum, because they will not be (significantly) consumed by the process of building the machine.

| Item        | Amount | Cost | Source                                                                         |
|-------------|--------|------|--------------------------------------------------------------------------------|
| Arduino IDE | 1      | €0   | [Arduino Website](https://www.arduino.cc/en/main/software)                     |
| OpenSCAD    | 1      | €0   | [OpenSCAD Website](http://www.openscad.org/downloads.html)                     |
| Cura        | 1      | €0   | [Ultimaker Website](https://ultimaker.com/en/products/ultimaker-cura-software) |

Tools
-----
These are the tools that I used to build the machine. Cheaper tools may be available, and in some cases I sourced these tools from somewhere else (for instance, I got the 3D printer for cheap from second-hand scraps). The alternatives will probably work fine for you.

The cost of these tools is not counted in the final sum, because they will not be (significantly) consumed by the process of building the machine.

| Item                       | Amount | Cost   | Source                                                                                                                                                      |
|----------------------------|--------|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Ultimaker 3                | 1      | €3599  | [Coolblue](https://www.coolblue.nl/product/745465/ultimaker-3.html)                                                                                         |
| CFH LD48 Soldering Station | 1      | €44.95 | [Hornbach](https://www.hornbach.nl/shop/CFH-Soldeerstation-digitaal-48-w/8368445/artikel.html)                                                              |
| Micro USB Cable            | 1      | €1.41  | [Aliexpress](https://www.aliexpress.com/item/OLAF-Nylon-Braided-Micro-USB-Cable-Data-Sync-USB-Charger-Cable-For-Samsung-HTC-Huawei-Xiaomi/32952616649.html) |

General Consumables
-------------------
These items are necessary for various parts of building the machine and will not be completely consumed by individual components. They do count in the total cost of the machine.

| Item                                          | Amount | Cost  | Source                                                                                                     |
|-----------------------------------------------|--------|-------|------------------------------------------------------------------------------------------------------------|
| Griffon Soldering Flux S39 Universal 50mL     | 1      | €5.20 | [Hornbach](https://www.hornbach.nl/shop/GRIFFON-Soldeervloeistof-S39-Universal-50-ml/5229070/artikel.html) |
| Griffon Electro Soldering Tin/Copper 1.5mm 3m | 1      | €8.78 | [Toolexperts](https://www.toolexperts.nl/electro-draadsoldeer-tin-koper99-1-harskern-1-5mm-in-koker-96958) |

LED Matrix
----------
These items are necessary to create the LED matrix display in the back of the machine.

| Item                   | Amount | Cost   | Source                                                                                                                                                   |
|------------------------|--------|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Lolin Wemos D1 Mini v3 | 1      | €2.26  | [Aliexpress](https://www.aliexpress.com/item/Wemos-D1-Mini-V3-0-0-WIFI-Internet-of-Things-Development-Board-Based-ESP8266-CH340-CH340G/32845084675.html) |
| 64x32 P5 LED Matrix    | 1      | €25.50 | [Tinytronics](https://www.tinytronics.nl/shop/nl/verlichting/led-matrix/64x32-rgb-led-matrix-320x160-mm)                                                 |
| Jumper Cables F-F 20cm | 15     | €0.26  | [Aliexpress](https://www.aliexpress.com/item/40pcs-dupont-cable-jumper-wire-dupont-line-female-to-female-dupont-line-20cm-1P-1P-for/32861366494.html)    |

Power Source
------------
These items are necessary for the electrical power sources of various voltages.

| Item                           | Amount | Cost  | Source                                                                                                                                    |
|--------------------------------|--------|-------|-------------------------------------------------------------------------------------------------------------------------------------------|
| 230V European Power Cable 1.8m | 1      | €4    | [Tinytronics](https://www.tinytronics.nl/shop/nl/kabels/230v-voeding/standaard-230v-voedingskabel-1.8m-haakse-stekker)                    |
| Mean Well 5V 10A Power Supply  | 1      | €9.36 | [Aliexpress](https://www.aliexpress.com/item/Original-MEAN-WELL-power-suply-unit-ac-to-dc-power-supply-NES-50-24-50W-24V/1503241952.html) |