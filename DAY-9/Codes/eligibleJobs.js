getErrorMessage(error) {
    console.error('FULL ERROR:', JSON.stringify(error));

    if (error && error.body) {

        if (error.body.message) {
            return error.body.message;
        }

        if (error.body.pageErrors && error.body.pageErrors.length > 0) {
            return error.body.pageErrors[0].message;
        }

        if (error.body.fieldErrors) {
            const fields = Object.keys(error.body.fieldErrors);

            if (fields.length > 0) {
                return error.body.fieldErrors[fields[0]][0].message;
            }
        }
    }

    if (error && error.message) {
        return error.message;
    }

    return 'Unknown error occurred.';
}
