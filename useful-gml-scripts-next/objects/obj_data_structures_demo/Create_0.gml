randomise();

function Foo() constructor {
	function bar(_a, _b) {
		return _a - _b;
	}
}

test_array = [
	1,
	-3,
	"foo",
	{ n: "bar" },
	[0, 2.333],
	function(_a, _b) { return _a + _b; },
	new Foo()
];
choice = choose_from_array(test_array);
found = array_find(test_array, "foo");

clone = deep_clone(test_array);

print(method_get_self(clone[6].bar));
print(method_get_self(test_array[6].bar));