while True:
    test = input("Hex Instruction: ")
    binary_string = ""
    for w in test:
        if w == '0': 
            binary_string += '0000'
        if w == '1': 
            binary_string += '0001'
        if w == '2': 
            binary_string += '0010'
        if w == '3': 
            binary_string += '0011'
        if w == '4': 
            binary_string += '0100'
        if w == '5': 
            binary_string += '0101'
        if w == '6': 
            binary_string += '0110'
        if w == '7': 
            binary_string += '0111'
        if w == '8': 
            binary_string += '1000'
        if w == '9': 
            binary_string += '1001'
        if w == 'A': 
            binary_string += '1010'
        if w == 'B': 
            binary_string += '1011'
        if w == 'C': 
            binary_string += '1100'
        if w == 'D': 
            binary_string += '1101'
        if w == 'E': 
            binary_string += '1110'
        if w == 'F': 
            binary_string += '1111'

    if binary_string[:6] == '000000':
        print("{}_{}_{}_{}_{}_{}".format(
            binary_string[:6], binary_string[6:11],
            binary_string[11:16], binary_string[16:21],
            binary_string[21:26], binary_string[26:]))

    elif binary_string[:6] in ['001000', '101011', '100011']:
        print("{}_{}_{}_{}".format(
            binary_string[:6], binary_string[6:11],
            binary_string[11:16], binary_string[16:]))

    elif binary_string[:6] == "000010":
        print("{}_{}".format(
            binary_string[:6], binary_string[6:]))

    else: 
        print("WRONG")
