import React from 'react';
import { Component } from 'react';
import {Navbar,Nav,NavItem,Glyphicon} from 'react-bootstrap';


class ToolBar extends Component {
  handleSelect(eventKey) {
    //event.preventDefault();
    alert(`selected ${eventKey}`);
  }

  render() {
    return (
      <Navbar>
        <Nav className="top-text">
          <NavItem>
            <h4 className="top-title">User One Current Points: 2,000</h4>
          </NavItem>
        </Nav>
        <Navbar.Header>
          <Navbar.Brand>
            <a href="#home">Driver Image</a>
          </Navbar.Brand>
        </Navbar.Header>
        <Nav bsStyle="tabs" activeKey="1" onSelect={k => this.handleSelect(k)}>
          <NavItem eventKey="1" href="/home">
            <Glyphicon glyph="th" />
            Catalog
          </NavItem>
          <NavItem eventKey="2">
            <Glyphicon glyph="tag" />
            Orders
          </NavItem>
          <NavItem eventKey="3">
            <Glyphicon glyph="asterisk" />
            Settings
          </NavItem>
          <NavItem eventKey="4">
            <Glyphicon glyph="shopping-cart" />
            Cart
          </NavItem>
        </Nav>
      </Navbar>
   );
  }
}

export default ToolBar;
