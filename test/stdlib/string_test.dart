import 'package:lua_dardo_async/lua.dart';
import 'package:test/test.dart';


Future<bool> testString() async {
  try{
    LuaState state = LuaState.newState();
    await state.openLibs();
    state.loadString(r'''
--[[
multi-line comments
multi-line comments
]]

a = [[abc
123]]
b = [==[
abc
123]==]
print(a)
print(b)
str = 'a string with "quotes" and \n new line\r\n'
print(str)
print(string.gsub("hello world", "(%w+)", "%1 %1"))
print(string.len("abc"))
print(string.byte("abcABC", 1, 6))
print(string.char(97, 98, 99))
print(string.upper("acde"))
print(string.find("8Abc%a23", "%a"))
print(string.find("8Abc%a23", "(%a)"))
print(string.find("8Abc%a23", "(%a)", 4))
print(string.find("8Abc%a23", "%a", 1, true))
print(string.find("8Abca23", "Ab"))
print(string.match("abc123ABC456", "ABC"))
''');
    await state.pCall(0, 0, 1);
  }catch(e,s){
    print('$e\n$s');
    return false;
  }
  return true;
}

void main() {
  test('lua table standard library test', () async {
    expect(await testString(), true);
  });
}
