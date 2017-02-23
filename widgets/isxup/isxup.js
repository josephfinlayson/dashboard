import React from 'react';
import {Widget} from 'kitto';

import './isxup.scss';

class isxup extends Widget {


    status() {
        return`status-${this.state.isUp && this.state.isUp.toString()}`;
    }

    render() {
        return (
            <div className={`${this.props.className} ${this.status()}`}>
                <h1 className="title">Is CBLCA Up?</h1>
                <h3>{this.state.isUp ? "Maybe" : "No" }</h3>
                <div className="container">
                <p className="updated-at">{this.updatedAt(this.state.updated_at)}</p>
                <p className="right-block">Minutes Up: {this.state.minutesUp}</p>
                <p className="left-block">Minutes Down: {this.state.minutesDown}</p>
                </div>
            </div>
        );
    }
};

Widget.mount(isxup);
export default isxup;
