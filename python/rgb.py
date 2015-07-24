import unittest
        
def hexToRgb(value):
    #Convert string to hexadecimal number (base 16)
    num = (int(value.lstrip("#"), 16))

    #Shift 16 bits to the right, and then binary AND to obtain 8 bits representing red
    r = ((num >> 16) & 0xFF)

    #Shift 8 bits to the right, and then binary AND to obtain 8 bits representing green
    g = ((num >> 8) & 0xFF)

    #Simply binary AND to obtain 8 bits representing blue
    b = (num & 0xFF)
    return (r, g, b)
    
class ExpTests(unittest.TestCase):
    def test_exponent_rgb(self):
        self.assertEqual(hexToRgb("#000000"), (0,0,0))
        self.assertEqual(hexToRgb("#FF0000"), (255,0,0))
        self.assertEqual(hexToRgb("#00FF00"), (0,255,0))
        self.assertEqual(hexToRgb("#0000FF"), (0,0,255))
        self.assertEqual(hexToRgb("#FFFFFF"), (255,255,255))

def main():
    unittest.main()
    

if __name__ == '__main__':
    main()