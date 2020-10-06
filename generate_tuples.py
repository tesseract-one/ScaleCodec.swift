import sys

def generate_tuple_struct_name(size: int):
  return "STuple" + str(size)

def generate_type_list(size: int):
  return ", ".join(["T"+str(i+1) for i in range(0, size)])

def generate_type_list_protocol(size: int, proto: str, prefix: str = "\t\t"):
  l = []
  for x in range(0, size, 3):
    line = prefix + ", ".join(["T"+str(x+y+1)+": "+proto for y in range(0, min(size - x, 3))])
    l.append(line)
  return ",\n".join(l)

def generate_encode_list(size: int):
  l = []
  for x in range(0, size, 5):
    line = "\t\t\t." + ".".join(["encode(_"+str(x+y)+")" for y in range(0, min(size - x, 5))])
    l.append(line)
  return "\n".join(l)

def generate_decode_list(size: int):
  l = []
  for x in range(0, size, 3):
    line = "\t\t\t" + ", ".join(["decoder.decode()"] * min(size - x, 3))
    l.append(line)
  return ",\n".join(l)

def print_tuple_struct(size: int):
  name = generate_tuple_struct_name(size)
  line = "public struct "+name+"<"+generate_type_list(size)+"> {"
  print(line)
  for i in range(0, size):
    print("\tpublic let _"+str(i)+": T"+str(i+1))
  print("")
  initvars = ", ".join(["_ v"+str(i+1)+": T"+str(i+1) for i in range(0, size)])
  print("\tpublic init("+initvars+") {")
  initvars = "; ".join(["_"+str(i)+" = v"+str(i+1) for i in range(0, size)])
  print("\t\t"+initvars+"\n\t}\n")
  print("\tpublic init(_ t: ("+generate_type_list(size)+")) {")
  initvars = ", ".join(["t."+str(i) for i in range(0, size)])
  print("\t\tself.init("+initvars+")\n\t}\n")
  print("\tpublic var tuple: ("+generate_type_list(size)+") {")
  initvars = ", ".join(["_"+str(i) for i in range(0, size)])
  print("\t\treturn ("+initvars+")\n\t}\n}\n")

def print_tuple_encodable(size: int):
  name = generate_tuple_struct_name(size)
  print("extension "+name+": ScaleEncodable\n\twhere")
  print(generate_type_list_protocol(size, "ScaleEncodable"))
  print("{\n\tpublic func encode(in encoder: ScaleEncoder) throws {")
  print("\t\ttry encoder")
  print(generate_encode_list(size))
  print("\t}\n}\n")

def print_tuple_decodable(size: int):
  name = generate_tuple_struct_name(size)
  print("extension "+name+": ScaleDecodable\n\twhere")
  print(generate_type_list_protocol(size, "ScaleDecodable"))
  print("{\n\tpublic init(from decoder: ScaleDecoder) throws {")
  print("\t\ttry self.init(")
  print(generate_decode_list(size))
  print("\t\t)\n\t}\n}\n")

def print_scale_decoder_ext(size: int):
  name = generate_tuple_struct_name(size)
  print("extension ScaleDecoder {")
  typel = generate_type_list(size)
  print("\tpublic func decode<"+typel+">(_ t: ("+typel+").Type) throws -> ("+typel+")\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleDecodable", prefix="\t\t\t"))
  print("\t{\n\t\treturn try self.decode("+name+"<"+typel+">.self).tuple\n\t}\n")
  print("\tpublic func decode<"+typel+">() throws -> ("+typel+")\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleDecodable", prefix="\t\t\t"))
  print("\t{\n\t\treturn try self.decode("+name+"<"+typel+">.self).tuple\n\t}\n}\n")

def print_scale_encoder_ext(size: int):
  name = generate_tuple_struct_name(size)
  print("extension ScaleEncoder {\n\t@discardableResult")
  typel = generate_type_list(size)
  print("\tpublic func encode<"+typel+">(_ value: ("+typel+")) throws -> ScaleEncoder\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleEncodable", prefix="\t\t\t"))
  print("\t{\n\t\ttry self.encode(STuple(value))\n\t}\n}\n")

def print_stuple_helper(size: int):
  name = generate_tuple_struct_name(size)
  typel = generate_type_list(size)
  print("public func STuple<"+typel+">(_ t: ("+typel+")) -> "+name+"<"+typel+"> {")
  print("\treturn "+name+"(t)\n}\n")

def print_scale_ext(size: int):
  name = generate_tuple_struct_name(size)
  typel = generate_type_list(size)
  print("extension SCALE {")
  print("\tpublic func encode<"+typel+">(_ value: ("+typel+")) throws -> Data\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleEncodable", prefix="\t\t\t"))
  print("\t{\n\t\treturn try self.encode(STuple(value))\n\t}\n")
  print("\tpublic func decode<"+typel+">(_ t: ("+typel+").Type, from data: Data) throws -> ("+typel+")\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleDecodable", prefix="\t\t\t"))
  print("\t{\n\t\treturn try self.decode(from: data)\n\t}\n")
  print("\tpublic func decode<"+typel+">(from data: Data) throws -> ("+typel+")\n\t\twhere")
  print(generate_type_list_protocol(size, "ScaleDecodable", prefix="\t\t\t"))
  print("\t{\n\t\treturn try self.decode("+name+"<"+typel+">.self, from: data).tuple\n\t}\n}\n")

def print_tuple(size: int):
  print("// ========================")
  print("// Tuple for "+ str(size) +" elements")
  print("// ========================")
  print_tuple_struct(size)
  print_stuple_helper(size)
  print_tuple_encodable(size)
  print_tuple_decodable(size)
  print_scale_decoder_ext(size)
  print_scale_encoder_ext(size)
  print_scale_ext(size)

if __name__ == "__main__":
  argv1 = sys.argv[1] if len(sys.argv) > 1 else "9"
  amount = int(argv1)
  for i in range(0, amount):
    print_tuple(i+2)