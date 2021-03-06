/// Portable, pure Swift color representation.
public struct RGBColor: Equatable {

	// MARK: - Properties

	public var red: Double
	public var green: Double
	public var blue: Double


	// MARK: - Initializers

	public init(red: Double, green: Double, blue: Double) {
        precondition(red >= 0 && red <= 1)
        precondition(green >= 0 && green <= 1)
        precondition(blue >= 0 && blue <= 1)

		self.red = red
		self.green = green
		self.blue = blue
	}

	public init(white: Double) {
        precondition(white >= 0 && white <= 1)

		self.init(red: white, green: white, blue: white)
	}

	public init(hslColor: HSLColor) {
		let saturation = hslColor.saturation
		let lightness = hslColor.lightness

		if saturation == 0 {
			self.init(white: lightness)
			return
		}

		let hue = hslColor.hue

		let t1: Double
		let t2: Double

		if lightness < 0.5 {
			t2 = lightness * (1 + saturation)
		} else {
			t2 = lightness + saturation - lightness * saturation
		}

		t1 = 2 * lightness - t2

		var rgb: [Double] = [0, 0, 0]

		for i in 0..<3 {
			var t3 = hue + 1 / 3 * -(Double(i) - 1)

			if t3 < 0 {
				t3 += 1
			}

			if t3 > 1 {
				t3 -= 1
			}

			let value: Double

			if (6 * t3 < 1) {
				value = t1 + (t2 - t1) * 6 * t3
			} else if (2 * t3 < 1) {
				value = t2
			} else if (3 * t3 < 2) {
				value = t1 + (t2 - t1) * (2 / 3 - t3) * 6
			} else {
				value = t1
			}
			
			rgb[i] = value
		}

		self.init(red: rgb[0], green: rgb[1], blue: rgb[2])
	}
}
