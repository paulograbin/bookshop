using {
    sap.common.Languages as CommonLanguages,
                            cuid
} from '@sap/cds/common';
using {sap.capire.bookshop as my} from '../db/schema';
using {sap.capire.bookshop as orders} from '../db/orders';

service AdminService @(requires: 'authenticated-user') {
    entity Books          as projection on my.Books;
    entity Authors        as projection on my.Authors;


    entity Orders         as select from orders.Orders;

    type NextSibling : cuid {};

    entity GenreHierarchy as projection on my.Genres
                             //     excluding {children} order by siblingRank
        actions {
            // Custom Handler -> HierarchySiblingActionHandler.java
            // Experimental UI feature, see:
            // https://github.com/SAP/odata-vocabularies/blob/main/vocabularies/Hierarchy.md#template_changenextsiblingaction-experimental
            action moveSibling(NextSibling: NextSibling);
        };


    annotate AdminService.Books with @cds.search: {
        descr,
        title
    };

    // Enable Fiori Draft for Orders
    annotate AdminService.Orders with @odata.draft.enabled;
    annotate AdminService.Books with @odata.draft.enabled;
    annotate AdminService.GenreHierarchy with @odata.draft.enabled;


    annotate AdminService.OrderItems {
        quantity @changelog;
        book     @changelog: [
            book.title,
            book.isbn
        ]
    };

}
