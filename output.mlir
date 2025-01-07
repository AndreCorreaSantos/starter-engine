module {
func.func @main() {
%_fc1.weight = "engine.constant"() {value=dense<[[-0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, -0.0, 0.1, 0.1, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.0, -0.1, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.0, 0.1, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, -0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, 0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.0, -0.1, -0.1, -0.2, -0.1, -0.0, -0.0, -0.1, -0.1, -0.1, 0.0, 0.1, 0.1, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, 0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.0, -0.0, -0.2, -0.2, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, 0.1, 0.1, 0.2, 0.2, 0.1, -0.1, -0.1, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.0, 0.1, 0.0, 0.1, 0.1, 0.3, 0.3, 0.2, 0.0, -0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.0, 0.1, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, 0.1, 0.1, 0.2, 0.3, 0.2, 0.1, 0.1, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.1, 0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.1, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.1, 0.1, 0.0, 0.1, 0.1, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.1, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, -0.0, -0.2, -0.2, -0.1, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, -0.0, -0.0, -0.1, -0.1, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.0, -0.0, -0.0, 0.1, 0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.1, 0.2, 0.1, 0.1, 0.1, 0.2, 0.1, 0.1, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, 0.1, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.1, 0.1, 0.1, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.1, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0], [-0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.1, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.1, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.1, -0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.0, 0.1, 0.1, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.3, 0.2, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.3, 0.3, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.1, 0.2, 0.3, 0.3, 0.2, 0.1, 0.1, -0.0, -0.1, -0.1, -0.1, -0.0, -0.1, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.1, 0.2, 0.3, 0.3, 0.2, 0.1, 0.0, -0.1, -0.2, -0.2, -0.2, -0.1, -0.1, -0.1, -0.1, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.2, 0.2, 0.2, 0.1, 0.0, -0.1, -0.1, -0.2, -0.2, -0.1, -0.1, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.1, -0.2, -0.2, -0.2, -0.2, -0.1, -0.1, -0.0, -0.1, -0.1, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, 0.1, 0.1, -0.0, 0.1, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, 0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, -0.1, 0.0, -0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.1, -0.1, -0.1, -0.0, -0.1, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0], [0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, -0.0, 0.0, -0.0, -0.0, -0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.1, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.1, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, -0.0, -0.1, -0.1, 0.1, 0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.1, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.1, -0.0, 0.0, 0.0, 0.1, 0.1, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, 0.1, 0.1, 0.0, 0.0, 0.1, 0.2, 0.1, 0.2, 0.1, 0.0, -0.0, -0.0, -0.1, -0.1, -0.2, -0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, 0.1, -0.0, -0.0, -0.0, 0.1, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.1, -0.1, -0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.2, -0.2, -0.2, -0.1, -0.1, -0.0, 0.1, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.1, -0.0, -0.1, -0.2, -0.2, -0.2, -0.1, -0.1, -0.1, -0.0, 0.0, 0.0, 0.1, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.1, -0.1, -0.2, -0.1, -0.0, -0.0, -0.0, 0.1, 0.1, 0.0, 0.1, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.0, 0.1, 0.0, 0.0, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.0, -0.1, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.0, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.1, 0.2, 0.1, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0], [-0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.0, 0.0, 0.0, -0.0, 0.0, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.1, 0.1, 0.2, 0.1, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.1, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.1, -0.0, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.1, 0.2, 0.2, 0.2, 0.1, 0.0, -0.1, -0.1, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.0, 0.1, 0.1, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.1, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.1, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.2, 0.1, -0.0, -0.1, 0.0, 0.1, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.1, 0.2, 0.2, 0.2, 0.1, 0.1, 0.2, 0.2, 0.2, 0.1, -0.0, 0.1, 0.0, 0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.1, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, 0.0, 0.0, 0.1, -0.0, -0.0, -0.1, 0.0, 0.0, 0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.1, 0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, -0.0, -0.1, -0.0, 0.0, 0.1, 0.0, -0.1, -0.0, -0.0, 0.0, 0.0, -0.1, -0.1, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.2, -0.1, -0.0, 0.0, -0.0, -0.1, -0.0, -0.1, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.0, -0.0, 0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.1, -0.2, -0.2, -0.1, 0.0, 0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.1, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.2, -0.2, -0.1, -0.1, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, -0.0, 0.0, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.1, -0.2, -0.1, -0.1, -0.1, 0.0, -0.0, 0.0, 0.0, 0.0, -0.1, -0.1, -0.1, -0.1, -0.0, 0.0, 0.0, 0.0, -0.0, -0.1, -0.1, 0.0, 0.1, 0.1, 0.0, 0.0, -0.0, -0.1, -0.0, -0.0, -0.1, -0.1, -0.1, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.1, -0.0, -0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.1, 0.1, 0.2, 0.2, 0.2, 0.1, 0.1, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0], [-0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.1, 0.0, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.0, 0.0, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, 0.0, 0.1, 0.0, 0.0, 0.1, 0.1, 0.1, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.1, -0.0, -0.0, 0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.1, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, -0.1, -0.1, 0.0, -0.1, -0.0, 0.0, -0.1, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.1, 0.0, -0.0, 0.0, -0.0, -0.1, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.1, 0.0, -0.0, 0.0, -0.0, 0.0, -0.1, -0.2, -0.1, 0.0, 0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.1, 0.1, 0.1, -0.1, -0.2, -0.0, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.1, 0.1, 0.1, 0.2, 0.1, -0.1, -0.1, 0.0, 0.1, 0.1, 0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.1, -0.1, -0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.2, 0.1, -0.0, -0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.1, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, 0.0, 0.1, 0.2, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.0, 0.0, -0.0, 0.0, -0.0, -0.1, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.2, 0.0, 0.1, 0.0, -0.1, -0.1, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.1, 0.1, 0.0, -0.1, -0.1, -0.1, -0.1, -0.1, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.0, -0.1, -0.1, -0.0, 0.0, -0.0, 0.0, -0.0, -0.1, -0.0, -0.0, 0.1, 0.0, 0.0, -0.0, -0.1, -0.1, -0.0, -0.0, 0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.1, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, -0.1, -0.0, -0.1, -0.0, -0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.2, -0.1, -0.1, -0.0, 0.1, 0.1, 0.1, 0.2, 0.1, 0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, -0.0, -0.1, 0.0, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.1, -0.1, -0.1, -0.0, -0.0, -0.1, -0.1, -0.0, -0.0, -0.0, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.1, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, -0.0, 0.1, 0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.1, -0.0, -0.1, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.1, -0.0, -0.1, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0, 0.0, -0.0, -0.0, -0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, 0.0, 0.0, 0.0, -0.0, -0.0, 0.0, -0.0, 0.0, -0.0, -0.0, -0.0]]>:tensor<5x784xf64>} : () -> memref<5x784xf64>
%_fc1.bias = "engine.constant"() {value=dense<[0.0, -0.2, 0.3, 0.5, 0.2]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc2_left2.weight = "engine.constant"() {value=dense<[[0.8, 0.4, -0.5, 0.3, 0.2], [0.6, 0.1, -0.3, 1.1, -0.9], [-0.1, -0.6, 0.8, 1.0, 0.2], [1.0, -0.2, 0.7, -0.6, -0.6], [-0.3, 1.5, 1.0, -0.0, 0.2]]>:tensor<5x5xf64>} : () -> memref<5x5xf64>
%_fc2_left2.bias = "engine.constant"() {value=dense<[0.3, -0.1, 0.0, -0.2, 0.2]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc2_right.weight = "engine.constant"() {value=dense<[[0.8, 0.3, -0.4, 0.2, 0.8], [-0.2, -0.0, -0.2, -0.1, 0.1], [-0.4, -0.2, 0.5, 1.0, 0.3], [1.0, -0.5, 0.7, -0.3, -0.7], [-0.3, 0.1, -0.2, -0.2, -0.1]]>:tensor<5x5xf64>} : () -> memref<5x5xf64>
%_fc2_right.bias = "engine.constant"() {value=dense<[0.0, -0.1, -0.1, 0.1, 0.0]>:tensor<5xf64>} : () -> memref<5xf64>
%_fc3.weight = "engine.constant"() {value=dense<[[-0.0, 0.7, 0.5, 0.4, -1.4], [-0.4, -0.3, -0.8, 0.2, 1.1], [-0.0, -0.6, -0.5, 1.1, 0.1], [-0.3, -0.5, 0.2, 0.8, 0.2], [0.7, -0.5, 0.1, -1.3, 0.3], [0.1, 0.7, 0.2, 0.1, -0.2], [1.0, -0.1, -0.8, -0.1, -0.4], [-1.2, -0.4, 1.0, -0.3, 0.3], [-0.1, 0.8, -0.4, 0.2, 0.5], [-0.3, 0.2, 0.5, -0.6, 0.5]]>:tensor<10x5xf64>} : () -> memref<10x5xf64>
%_fc3.bias = "engine.constant"() {value=dense<[-1.0, 0.8, 0.3, -0.1, -0.1, 0.1, 0.1, 0.2, -0.7, 0.0]>:tensor<10xf64>} : () -> memref<10xf64>
%_onnx.Flatten_0 = "engine.constant"() {value=dense<[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.7, 1.0, 1.0, 0.6, 0.4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.9, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 1.0, 1.0, 1.0, 0.8, 0.6, 0.7, 1.0, 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 1.0, 1.0, 0.8, 0.1, 0.0, 0.0, 0.0, 0.8, 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 1.0, 0.8, 0.1, 0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.8, 1.0, 1.0, 0.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 0.8, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 1.0, 1.0, 0.9, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 1.0, 1.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.9, 1.0, 0.9, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 1.0, 1.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 1.0, 1.0, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.8, 1.0, 1.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 1.0, 1.0, 0.7, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0.2, 0.1, 0.1, 0.1, 0.1, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0.6, 0.6, 0.6, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.7, 0.6, 0.7, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.7, 0.5, 0.5, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0.5, 0.7, 1.0, 1.0, 1.0, 0.6, 0.5, 0.5, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]>:tensor<784xf64>} : () -> memref<784xf64>
%_.Flatten_output_0 = "engine.flatten"(%_onnx.Flatten_0) : (memref<784xf64>) -> memref<784xf64> 
%_.fc1.Gemm_output_0_int = "engine.matmul"(%_fc1.weight,%_.Flatten_output_0) : (memref<5x784xf64>,memref<784xf64>) -> memref<5xf64>
%_.fc1.Gemm_output_0 = "engine.add"(%_.fc1.Gemm_output_0_int,%_fc1.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_output_0 = "engine.relu"(%_.fc1.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.fc2_left2.Gemm_output_0_int = "engine.matmul"(%_fc2_left2.weight,%_.Relu_output_0) : (memref<5x5xf64>,memref<5xf64>) -> memref<5xf64>
%_.fc2_left2.Gemm_output_0 = "engine.add"(%_.fc2_left2.Gemm_output_0_int,%_fc2_left2.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_1_output_0 = "engine.relu"(%_.fc2_left2.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.fc2_right.Gemm_output_0_int = "engine.matmul"(%_fc2_right.weight,%_.Relu_output_0) : (memref<5x5xf64>,memref<5xf64>) -> memref<5xf64>
%_.fc2_right.Gemm_output_0 = "engine.add"(%_.fc2_right.Gemm_output_0_int,%_fc2_right.bias) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64>
%_.Relu_2_output_0 = "engine.relu"(%_.fc2_right.Gemm_output_0) : (memref<5xf64>) -> memref<5xf64> 
%_.Add_output_0 = "engine.add"(%_.Relu_1_output_0,%_.Relu_2_output_0) : (memref<5xf64>,memref<5xf64>) -> memref<5xf64> 
%_17_int = "engine.matmul"(%_fc3.weight,%_.Add_output_0) : (memref<10x5xf64>,memref<5xf64>) -> memref<10xf64>
%_17 = "engine.add"(%_17_int,%_fc3.bias) : (memref<10xf64>,memref<10xf64>) -> memref<10xf64>
"engine.print"(%_17) : (memref<10xf64>) -> ()
return
}
}