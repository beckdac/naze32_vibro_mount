// Requires OpenSCAD 2016.3+

/* [Main] */

// select part
part = "assembly";
//part = "naze32";
//part = "naze32Plate";
//part = "earplug";
//part = "f450Plate";
// plate thicknesses (mm) where not otherwise specified
plateThickness = 3;

/* [Misc] */
// rounding factor (mm)
roundingFactor = 8;
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
naze32AccessCutoutWidth = (naze32MountHoleSep - 2 * naze32MountHoleD) * 1.5;
naze32MountPlateHoleSep = 44;	// holes for ear plugs into f450 plate
naze32MountPlateHoleD = 5;		// holes to fit plugs, add a little superglue
naze32MountPlateWidth = naze32MountPlateHoleSep; // + naze32MountPlateHoleD / 2;
naze32MountPlateStandoff = 4;

/* [earplug] */
earplugStandoff = 6;
earplugAboveBelow = 3;
earplugD = 10;

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

module naze32() {
	difference() {
		hull() {
			for (i=[-1,1])
				for (j=[-1,1])
					translate([i * (naze32Width / 2 - (roundingFactor / 2)),
								j * (naze32Width / 2 - (roundingFactor / 2)),
								0])
						cylinder(h=plateThickness / 3, d=roundingFactor, center=true);
		}
		for (i=[-1,1])
			for (j=[-1,1])
				translate([i * naze32MountHoleSep / 2,
						j * naze32MountHoleSep / 2,
						0])
					cylinder(h=plateThickness / 3 + cylHeightExt, d=naze32MountHoleD, center=true);
	}
}

module naze32Plate() {
	difference() {
		hull() {
			for (i=[-1,1])
				for (j=[-1,1]) {
					translate([i * (naze32MountHoleSep / 2),
								j * (naze32MountHoleSep / 2),
								-naze32MountPlateStandoff])
						cylinder(h=plateThickness, d=roundingFactor, center=true);
					translate([i * naze32MountPlateWidth / 2,
								0,
								-naze32MountPlateStandoff])
						cylinder(h=plateThickness, d=1.5 * roundingFactor, center=true);
					translate([0,
								i * naze32MountPlateWidth / 2,
								-naze32MountPlateStandoff])
						cylinder(h=plateThickness, d=1.5 * roundingFactor, center=true);
				}
		}
		for (i=[-1,1])
			for (j=[-1,1])
				translate([i * naze32MountHoleSep / 2,
						j * naze32MountHoleSep / 2,
						-naze32MountPlateStandoff])
					cylinder(h=plateThickness + cylHeightExt, d=naze32MountHoleD, center=true);
		for (i=[-1,1]) {
			translate([i * naze32MountPlateHoleSep / 2,
				0,
				-naze32MountPlateStandoff])
			cylinder(h=plateThickness + cylHeightExt, d=naze32MountPlateHoleD, center=true);
			translate([0,
				i * naze32MountPlateHoleSep / 2,
				-naze32MountPlateStandoff])
			cylinder(h=plateThickness + cylHeightExt, d=naze32MountPlateHoleD, center=true);
		}

		translate([0, 0, -naze32MountPlateStandoff])
			cylinder(h=plateThickness + cylHeightExt, d=naze32AccessCutoutWidth, center=true);
	}
}

module earplug() {
}

module f450Plate() {
	difference() {
		hull() {
			for (i=[-1,1]) {
				translate([i * f450MountPlateWidth / 2,
						0,
						-naze32MountPlateStandoff - earplugStandoff])
					cylinder(h=plateThickness + cylHeightExt, d=naze32MountPlateHoleD, center=true);
				translate([0,
						i * f450MountPlateWidth / 2,
						-naze32MountPlateStandoff - earplugStandoff])
					cylinder(h=plateThickness + cylHeightExt, d=naze32MountPlateHoleD, center=true);
			}
		}
		for (i=[-1,1])
			for (j=[-1,1]) {
				translate([i * naze32MountPlateHoleSep,
						j * naze32MountPlateHoleSep,
						-naze32MountPlateStandoff - earplugStandoff])
					cylinder(h=plateThickness + cylHeightExt * 2, d=80, center=true);
			}
		for (i=[-1,1]) {
			translate([i * naze32MountPlateHoleSep / 2,
					0,
					-naze32MountPlateStandoff - earplugStandoff])
				cylinder(h=plateThickness + cylHeightExt * 2, d=naze32MountPlateHoleD, center=true);
			translate([0,
					i * naze32MountPlateHoleSep / 2,
					-naze32MountPlateStandoff - earplugStandoff])
				cylinder(h=plateThickness + cylHeightExt * 2, d=naze32MountPlateHoleD, center=true);
		}
		for (i=[-1,1]) {
			translate([i * f450MountPlateHoleSep / 2,
					0,
					-naze32MountPlateStandoff - earplugStandoff])
				cylinder(h=plateThickness + cylHeightExt * 2, d=f450MountPlateHoleD, center=true);
			translate([0,
					i * f450MountPlateHoleSep / 2,
					-naze32MountPlateStandoff - earplugStandoff])
				cylinder(h=plateThickness + cylHeightExt * 2, d=f450MountPlateHoleD, center=true);
		}
		translate([0, 0, -naze32MountPlateStandoff - earplugStandoff])
			cylinder(h=plateThickness + cylHeightExt * 2, d=naze32AccessCutoutWidth, center=true);
	}
}
