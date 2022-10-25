codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    var
        CLIPMin: Codeunit "CLIP Min";
        Value1, Value2 : Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 1;
        Value2 := 2;

        // [When] se llama a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] el resultado tiene que ser el menos de los 2 valores numéricos
        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test002()
    var
        CLIPMin: Codeunit "CLIP Min";
        Value1, Value2 : Decimal;
        Result: Decimal;
    begin
        // [Scenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos
        Value1 := 3;
        Value2 := 2;

        // [When] se llama a la función GetMin
        Result := CLIPMin.GetMin(Value1, Value2);

        // [Then] el resultado tiene que ser el menos de los 2 valores numéricos
        if Result <> Value2 then
            Error('El resultado no es correcto');
    end;
}