codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure SelectCourseOnSalesDocuments()
    begin
        // [Scenario] Se puede seleccionar un curso en una línea de venta

        SelectCourseOnSalesDocument("Sales Document Type"::Quote);
        SelectCourseOnSalesDocument("Sales Document Type"::Order);
        SelectCourseOnSalesDocument("Sales Document Type"::"Blanket Order");
        SelectCourseOnSalesDocument("Sales Document Type"::Invoice);
        SelectCourseOnSalesDocument("Sales Document Type"::"Credit Memo");
        SelectCourseOnSalesDocument("Sales Document Type"::"Return Order");
    end;

    local procedure SelectCourseOnSalesDocument(SalesDocumentType: Enum "Sales Document Type")
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [Given] Un curso configurado con: nombre, grupos contables, precio
        Course := LibraryCourses.CreateCourse();
        //         Un documento de venta
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::Item, '', 1);
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Seleccionamos el curso en una línea venta
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] La línea de venta tiene la Nombre del curso, el precio y los grupos contables
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo contable producto no es correcto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo IVA producto no es correcto');
    end;

    [Test]
    procedure PostingASalesDocument()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvoiceLine: Record "Sales Invoice Line";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        PostedDocumentNo: Code[20];
    begin
        // [Scenario] Al registrar un documento de venta con una línea de tipo Curso, con una edición seleccionada, la edición se traslada a los documentos registrados

        // [Given] Un curso con ediciones
        Course := LibraryCourses.CreateCourse();
        CourseEdition := LibraryCourses.CreateCourseEdition(Course."No.");
        //          Un documento de venta para el curso y edición
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"CLIP Course", Course."No.", 1);
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Modify();

        // [When] Registramos el documento de venta
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] La edición se ha guardado correctamente en los documentos registrados
        SalesInvoiceLine.SetRange("Document No.", PostedDocumentNo);
        SalesInvoiceLine.FindFirst();
        LibraryAssert.AreEqual(CourseEdition.Edition, SalesInvoiceLine."CLIP Course Edition", 'La edición no se ha guardado correctamente en la factura de venta');
    end;

    [Test]
    procedure CourseSalesPosting()
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        PostedDocumentNo: Code[20];
    begin
        // [Scenario] Al registrar la venta de un curso (y edición), se crea un movimiento de curso

        // [Given] Un curso con ediciones
        Course := LibraryCourses.CreateCourse();
        CourseEdition := LibraryCourses.CreateCourseEdition(Course."No.");
        //          Un documento de venta para el curso y edición
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"CLIP Course", Course."No.", 1);
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Modify();

        // [When] Registramos el documento de venta
        PostedDocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] Se ha creado UN movimiento de curso con los datos adecuados
        CourseLedgerEntry.SetRange("Document No.", PostedDocumentNo);
        LibraryAssert.AreEqual(1, CourseLedgerEntry.Count(), 'Nº de movimientos incorrecto');
        CourseLedgerEntry.FindFirst();
        LibraryAssert.AreEqual(SalesHeader."Posting Date", CourseLedgerEntry."Posting Date", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."No.", CourseLedgerEntry."Course No.", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."CLIP Course Edition", CourseLedgerEntry."Course Edition", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine.Description, CourseLedgerEntry.Description, 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine.Quantity, CourseLedgerEntry.Quantity, 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine."Unit Price", CourseLedgerEntry."Unit Price", 'Dato incorrecto');
        LibraryAssert.AreEqual(SalesLine.Amount, CourseLedgerEntry."Total Price", 'Dato incorrecto');
    end;

    [Test]
    procedure SelectEditionOnSalesDocuments_CheckEditionMaxStudents()
    begin
        // [Scenario] Al seleccionar una edición en un curso de venta, el sistema comprueba si se ha llegado al número máximo de alumnos

        // SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::Quote);
        SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::Order);
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::"Blanket Order");
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::Invoice);
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::"Credit Memo");
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents("Sales Document Type"::"Return Order");
    end;

    local procedure SelectEditionOnSalesDocument_CheckEditionMaxStudents(SalesDocumentType: Enum "Sales Document Type")
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [Given] Un curso configurado con: nombre, grupos contables, precio
        Course := LibraryCourses.CreateCourse();
        CourseEdition := LibraryCourses.CreateCourseEdition(Course."No.", 6);

        // Algunos movimientos previos
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify();
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify();
        LibrarySales.PostSalesDocument(SalesHeader, true, true);

        //         Un documento de venta
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Seleccionamos el curso y edición en la línea venta
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 3);

        // [Then] Nada, el sistema no tiene que mostrar ninguna notificación
    end;

    [Test]
    [HandlerFunctions('MessageMaxStudentsExceeded')]
    procedure SelectEditionOnSalesDocuments_CheckEditionMaxStudents_ShowNotification()
    begin
        // [Scenario] Al seleccionar una edición en un curso de venta, el sistema comprueba si se ha llegado al número máximo de alumnos

        // SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::Quote);
        SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::Order);
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::"Blanket Order");
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::Invoice);
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::"Credit Memo");
        // SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification("Sales Document Type"::"Return Order");
    end;

    [MessageHandler]
    procedure MessageMaxStudentsExceeded(Message: Text[1024])
    var
        LibraryAssert: Codeunit "Library Assert";
        MaxStudentsExceededMsg: Label 'The current sale for course', comment = 'ESP="La venta actual para el curso"';
    begin
        LibraryAssert.AreEqual(true, Message.Contains(MaxStudentsExceededMsg), 'El mensaje no es el correcto');
    end;

    local procedure SelectEditionOnSalesDocument_CheckEditionMaxStudents_ShowNotification(SalesDocumentType: Enum "Sales Document Type")
    var
        Course: Record "CLIP Course";
        CourseEdition: Record "CLIP Course Edition";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [Given] Un curso configurado con: nombre, grupos contables, precio
        Course := LibraryCourses.CreateCourse();
        CourseEdition := LibraryCourses.CreateCourseEdition(Course."No.", 4);

        // Algunos movimientos previos
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify();
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify();
        LibrarySales.PostSalesDocument(SalesHeader, true, true);

        //         Un documento de venta
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Seleccionamos el curso y edición en la línea venta
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");
        SalesLine.Validate("CLIP Course Edition", CourseEdition.Edition);
        SalesLine.Validate(Quantity, 5);

        // [Then] El sistema tiene que mostrar una notificación
    end;
}