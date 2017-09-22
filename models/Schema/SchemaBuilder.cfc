component accessors="true" singleton {

    property name="grammar";
    property name="defaultStringLength" default="255";

    function init( grammar ) {
        variables.grammar = arguments.grammar;
        return this;
    }

    function create( table, callback, options = {}, build = true ) {
        var blueprint = new Blueprint( this, getGrammar() );
        blueprint.addCommand( "create" );
        blueprint.setTable( table );
        callback( blueprint );
        if ( build ) {
            blueprint.getSql().each( function( statement ) {
                getGrammar().runQuery( statement, {}, options, "result" );
            } );
        }
        return blueprint;
    }

    function drop( table, options = {}, build = true ) {
        var blueprint = new Blueprint( this, getGrammar() );
        blueprint.addCommand( "drop" );
        blueprint.setTable( table );
        if ( build ) {
            blueprint.getSql().each( function( statement ) {
                getGrammar().runQuery( statement, {}, options, "result" );
            } );
        }
        return blueprint;
    }

}
