// Requires OpenSCAD 2016.3+

/* [Main] */

// select part
part = "assembly";
//part = "naze32";
//part = "naze32Plate";
//part = "earplug";
//part = "f450Plate";
// plate thicknesses (mm) where not otherwise specified
plateThickness = 4;

/* [Misc] */

// interference fit adjustment for 3D printer
iFitAdjust = .4;
// cylinder subtract height extension
cylHeightExt = .1; // for overcutting on differences so they render correctly, nothing more
// render quality
$fn = 64; // [24:low quality, 48:development, 64:production]

/* [naze32] */
naze32Width = 36;
naze32MountHoleSep = 30.5;
naze32MountHoleD = 3;

/* [naze32MountPlate] */
naze32AccessCutoutWidth = naze32MountHoleSep - 2 * naze32MountHoldD;
naze32MountPlateWidth = ;
naze32MountPlateHoleSep = ;     // holes for ear plugs into f450 plate
naze32MountPlateHoleD = 5;      // holes to fit plugs, add a little superglue

/* [earplug] */

/* [f450MountPlate] */
f450MountPlateHoleSep = 63.5;
f450MountPlateHoleD = 4;
f450MountPlateWidth = f450MountPlateHoleSep + 2 * f450MountPlateHoleD;

render_part();

module render_part() {
	if (part == "assembly") {
		assembly();
	} else if (part == "naze32") {
		naze32();
	} else if (part == "naze32Plate") {
		naze32Plate();
	} else if (part == "earplug") {
		earplug();
	} else if (part == "f450Plate") {
		f450Plate();
	} else {
		// invalid value
	}
}

module assembly() {
    union() {
        naze32();
		naze32Plate();
		earplug();
		f450Plate();
    }
}
