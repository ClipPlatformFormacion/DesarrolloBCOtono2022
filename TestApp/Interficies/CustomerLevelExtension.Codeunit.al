codeunit 50142 "CLIP Customer Level Extension"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'CLIPOnValidateCustomerLevelOnBeforeUnknownLevelError', '', false, false)]
    local procedure CLIPOnValidateCustomerLevelOnBeforeUnknownLevelError(var Customer: Record Customer; var Handled: Boolean);
    begin
        if Customer."CLIP Level" = "CLIP Customer Level"::"CLIP Gold" then begin
            Customer.Validate("CLIP Discount", 15);
            Handled := true;
        end;
    end;

}