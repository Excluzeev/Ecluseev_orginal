<template>
  	<div class="modal-content forgot-password-after">
		<div class="container">
			<div class="row">
				<div class="col-xl-12 text-center">
					<h2>Alrighty! <br>Set a password now.</h2>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="row">
				<div class="offset-xl-3 col-xl-6 offset-xl-3 offset-lg-2 col-lg-8 offset-lg-2 offset-sm-1 col-sm-10 offset-sm-1 text-center">
					<p>We’ll help you reclaim your glory. Just follow the instructions mentioned below.</p>
				</div>
			</div>
			<div class="row">
				<div class=" offset-xl-3 col-xl-6 offset-xl-3 offset-lg-2 col-lg-8 offset-lg-2 offset-sm-1 col-sm-10 offset-sm-1 ">
					<form>
						<div class="form-row text-center">
							<div class="form-group col-md-12 margin_bottom_none text-center">
								<div class="form-group col-md-12" >
									<span><i class="fa fa-lock"></i></span>
									<input type="name" class="form-control" id="enterNewPassword" placeholder="Please enter a new password">
								</div>
								<div class="form-group col-md-12">
									<span><i class="fa fa-lock"></i></span>
									<input type="password" class="form-control" id="confirmPassword" placeholder="Confirm the new password">
								</div>
								<br>
								<br>
								<div class="form-group col-md-12 text-center">
									<button class="btn btn-windowSaveIt">Save it, I remember this</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

  <!-- <div style="height:100%" class="blue lighten-1">
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <img
              style="padding-bottom:3%;padding-left:13%"
              alt="Excluzeev
            logo"
              src="../../assets/excluzeev_white.png"
            >
            <v-card class="elevation-12">
              <v-toolbar dark color="white">
                <v-toolbar-title class="blue--text lighten-1">Reset Password</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form class="blue--text lighten-1">
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Enter New Password"
                    type="password"
                  ></v-text-field>
                  <v-text-field
                    id="password"
                    prepend-icon="lock"
                    name="password"
                    label="Confrim New Password"
                    type="password"
                  ></v-text-field>
                  <div class="text-xs-center">
                    <v-btn
                      class="white--text v-btn--round"
                      color="blue lighten-1"
                      :loading="processing"
                      :disabled="processing"
                      @click="loader = 'loading4'"
                    >
                      Reset Password
                      <template v-slot:loader>
                        <span class="custom-loader">
                          <v-icon light>cached</v-icon>
                        </span>
                      </template>
                    </v-btn>
                  </div>
                </v-form>
              </v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </div> -->
</template>

<script>
export default {
  data: () => ({
    drawer: null
  }),

  props: {
    source: String
  }
};
</script>
