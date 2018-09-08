// Import modules ==============================================================
import React from 'react';
import { Provider } from 'react-redux';
import { Switch, Route } from 'react-router-dom';
import { ThemeProvider } from 'styled-components';
import { hot } from 'react-hot-loader';

// Import components ===========================================================
import { Auth } from 'component/util/Auth';
import { HomeView } from 'component/view/HomeView';
import { LoginView } from 'component/view/LoginView';


// Import styles ================================================================
import './globalStyles';

// TODO set a default theme
const theme = {
  body: 'onyx',
  heading: 'black',
  caption: 'darkGrey',
  footer: 'blue',
  background: '#fff',
};

const AuthView = props => <Auth {...props} ><HomeView /></Auth>;

const App = ({ store }) => (
  <ThemeProvider theme={theme}>
    <Provider store={store}>
      <Switch>
        <Route exact path="/" component={AuthView} />
        <Route exact path="/login" component={LoginView} />
      </Switch>
    </Provider>
  </ThemeProvider>
);

export default hot(module)(App);
