import React from "react"
import PropTypes from "prop-types"
class CinemaSlider extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div class="cinema-list">
          { this.props.cinemas.map((cinema, index) =>
            <div class="cinema-list-item">
              <img src={ this.props.cinema_urls[index] } alt="映画作品" />
              <p>{ cinema.title} </p>
            </div>
          )}
        </div>
      </React.Fragment>
    );
  }
}

CinemaSlider.propTypes = {
  cinemas: PropTypes.array,
  cinema_urls: PropTypes.array 
};
export default CinemaSlider
