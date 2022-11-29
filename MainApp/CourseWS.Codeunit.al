codeunit 50102 "CLIP Course WS"
{
    procedure UnMetodoSinParametrosNiValorDeRetorno()
    begin

    end;

    procedure UnMetodoConParametroDeTexto(TextoRecibido: Text): Text
    begin
        exit('Hola desde BC: ' + TextoRecibido);
    end;

    procedure CrearCliente(Name: Text[100]; Address: Text[100]; PhoneNo: Text[30]; CreditLimit: Decimal) CustomerNo: Text
    var
        Customer: Record Customer;
    begin
        if GuiAllowed() then
            if not Confirm('¿Estás seguro que quieres crear un nuevo cliente con Nombre %1?', true, Name) then
                Error('Proceso cancelado por el usuario');

        Customer.Init();
        Customer.Validate(Name, Name);
        Customer.Validate(Address, Address);
        Customer.Validate("Phone No.", PhoneNo);
        Customer.Validate("Credit Limit (LCY)", CreditLimit);
        Customer.Insert(true);

        CustomerNo := Customer."No.";
        // exit(Customer."No.");
    end;

    procedure CreateCourse(XMLPortToImport: XmlPort "CLIP Import Courses")
    begin
        XMLPortToImport.Import();
    end;
}