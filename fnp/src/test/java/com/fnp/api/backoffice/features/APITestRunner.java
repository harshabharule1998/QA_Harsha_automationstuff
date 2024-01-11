package com.fnp.api.backoffice.features;

import org.junit.runner.RunWith;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;


@RunWith(Karate.class)
@KarateOptions(features = "classpath:com/fnp/api/backoffice/features/category-management/category-master-supadmin-test.feature")
//@KarateOptions(features = "classpath:com/fnp/api/backoffice/features/users/user-details.feature")
//@KarateOptions(features = "classpath:com/fnp/api/backoffice/features/users/connect-db.feature")
//@KarateOptions(features = "classpath:com/fnp/api/backoffice/features/users/read-json.feature")

public class APITestRunner {

}
