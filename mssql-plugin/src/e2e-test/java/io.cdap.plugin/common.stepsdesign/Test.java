package io.cdap.plugin.common.stepsdesign;

import io.cdap.plugin.mssql.BQValidation;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;

public class Test {
    public static void main(String[] args) throws IOException, InterruptedException, SQLException, ClassNotFoundException, ParseException {
        BQValidation.validateBQToDBRecordValues("dbo","E2E_SOURCE_9739e","TARGETTABLE_PZOMNTDNCD");
        BQValidation.validateDBToBQRecordValues("dbo", "SOURCETABLE_ZPPKGKZDIK", "myTable");
    }
}
