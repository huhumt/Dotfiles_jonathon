window.addEventListener( "beforeunload", (event)=>{
	  // Cancel the event as stated by the standard.
	event.preventDefault();
	// Chrome requires returnValue to be set.
	event.returnValue = 'This is invision, not the site. Are you sure?';
	return 'This is invision, not the site. Are you sure?';
} );
